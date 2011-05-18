from django.utils.translation import ugettext_lazy as _
from django.utils.translation import ugettext
from django.core.urlresolvers import reverse
from django.utils.safestring import mark_safe

from metadata.classes import MetadataObject

from document_indexing.models import Index, IndexInstance
from document_indexing.conf.settings import AVAILABLE_INDEXING_FUNCTIONS
from document_indexing.conf.settings import FILESERVING_ENABLE
from document_indexing.conf.settings import FILESERVING_PATH
from document_indexing.conf.settings import SLUGIFY_PATHS

if SLUGIFY_PATHS == False:
    # Do not slugify path or filenames and extensions
    SLUGIFY_FUNCTION = lambda x: x
else:
    SLUGIFY_FUNCTION = slugify


# External functions
def update_indexes(document):
    """
    Update or create all the index instances related to a document
    """    
    warnings = []

    eval_dict = {}
    document_metadata_dict = dict([(metadata.metadata_type.name, metadata.value) for metadata in document.documentmetadata_set.all() if metadata.value])
    eval_dict['document'] = document
    eval_dict['metadata'] = MetadataObject(document_metadata_dict)

    for root in Index.objects.filter(parent=None):
        index_warnings = _evaluate_index(eval_dict, document, root)
        warnings.extend(index_warnings)

    return warnings


def delete_indexes(document):
    """
    Delete all the index instances related to a document
    """    
    warnings = []
    
    for node in document.indexinstance_set.all():
        _delete_document_from_node(document, node)
            
    return warnings


def get_instance_link(index_instance=None, text=None, simple=False):
    """
    Return an HTML anchor to an index instance
    """    
    
    if simple:
        # Just display the instance's value or overrided text, no
        # HTML anchor
        template = u'%(value)s'
    else:
        template = u'<a href="%(url)s">%(value)s</a>'
    if index_instance:
        return template % {
            'url': index_instance.get_absolute_url(), 'value': text if text else index_instance
        }
    else:
        # Root node
        return template % {
            'url': reverse('index_instance_list'), 'value': ugettext(u'root')
        }
        

def get_breadcrumbs(index_instance, simple=False, single_link=False):
    """
    Return a joined string of HTML anchors to every index instance's
    parent from the root of the tree to the index instance
    """    
    result = []
    if single_link:
        # Return the entire breadcrumb as a single HTML anchor
        simple = True
    
    result.append(get_instance_link(simple=simple))

    for instance in index_instance.get_ancestors():
        result.append(get_instance_link(instance, simple=simple))

    result.append(get_instance_link(index_instance, simple=simple))

    if single_link:
        return mark_safe(get_instance_link(index_instance=index_instance, text=(u' / '.join(result))))
    else:
        return mark_safe(u' / '.join(result))


# Internal functions
def _evaluate_index(eval_dict, document, node, parent_index_instance=None):
    """
    Evaluate an index expression and update or create all the related
    index instances also recursively calling itself to evaluate all the
    index's children
    """    
    warnings = []
    if node.enabled:
        try:
            result = eval(node.expression, eval_dict, AVAILABLE_INDEXING_FUNCTIONS)
            index_instance, created = IndexInstance.objects.get_or_create(index=node, value=result, parent=parent_index_instance)
            if node.link_documents:
                index_instance.documents.add(document)

            for children in node.get_children():
                children_warnings = _evaluate_index(eval_dict, document, children, index_instance)
                warnings.extend(children_warnings)

        except (NameError, AttributeError), exc:
            warnings.append(_(u'Error in document indexing update expression: %(expression)s; %(exception)s') % {
                'expression': node.expression, 'exception': exc})
            #raise NameError()
            #This should be a warning not an error
            #pass

        except Exception, exc:
            warnings.append(_(u'Error updating document index, expression: %(expression)s; %(exception)s') % {
                'expression': node.expression, 'exception': exc})
                
    return warnings



def _delete_document_from_node(document, node):
    """
    Delete a documents reference from an index instance and call itself
    recusively deleting documents and empty index instances up to the 
    root of the tree
    """
    warnings = []
    try:
        node.documents.remove(document)
        if node.documents.count() == 0 and node.get_children().count() == 0:
            parent = node.parent
            node.delete()
            parent_warnings = _delete_document_from_node(document, parent)
            warnings.extend(parent_warnings)
            
    except Exception, exc:
        warnings.append(_(u'Unable to delete document indexing node; %s') % exc)

    return warnings