#!/bin/sh
COMPILEMESSAGES="django-admin compilemessages"
PWD=`pwd`
BASE=$PWD

cd $BASE/apps/common
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/converter
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/documents
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/document_comments
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/document_indexing
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/dynamic_search
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/folders
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/history
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/linking
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/main
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/metadata
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/navigation
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/ocr
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/permissions
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/project_setup
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/project_tools
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/smart_settings
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/sources
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/tags
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/user_management
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/web_theme
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/django_gpg
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/document_signatures
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it

cd $BASE/apps/acls
$COMPILEMESSAGES -l pt
$COMPILEMESSAGES -l ru
$COMPILEMESSAGES -l es
$COMPILEMESSAGES -l it
