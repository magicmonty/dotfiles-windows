" Vim syntax file
" Language: paket.dependencies 
" Maintainer: Martin Gondermann
" Latest Revision: 02 May 2018

if exists("b:current_syntax")
  finish
endif

syn case match

syn match paketParameter /framework:/ nextgroup=paketFramework contains=paketFramework skipwhite
syn match paketFramework /net\d\+/ contained skipwhite
syn match paketFramework /netcoreapp\d\+/ contained skipwhite
syn match paketFramework /netstandard\d\+/ contained skipwhite
syn match paketFramework /net\d+-Unity Web v\d\+/ contained skipwhite
syn match paketFramework /net\d+-Unity Micro v\d\+/ contained skipwhite
syn match paketFramework /net\d+-Unity Subset v\d\+/ contained skipwhite
syn match paketFramework /net\d+-Unity Full v\d\+/ contained skipwhite
syn match paketFramework /monoandroid\d\+/ contained skipwhite
syn match paketFramework /monomac/ contained skipwhite
syn match paketFramework /monotouch/ contained skipwhite
syn match paketFramework /native/ contained skipwhite
syn match paketFramework /native([^()]\+)/ contained skipwhite
syn match paketFramework /xamarinmac/ contained skipwhite
syn match paketFramework /xamarinios/ contained skipwhite
syn match paketFramework /xamarinwatchos/ contained skipwhite
syn match paketFramework /xamarintvos/ contained skipwhite
syn match paketFramework /uap\d\+/ contained skipwhite
syn match paketFramework /win\d\+/ contained skipwhite
syn match paketFramework /wp\d\+/ contained skipwhite
syn match paketFramework /wpa\d\+/ contained skipwhite
syn match paketFramework /sl\d\+/ contained skipwhite
syn match paketFramework /tizen\d\+/ contained skipwhite
syn match paketFramework /auto-detect/ contained skipwhite
hi def link paketFramework Constant

syn match paketParameter /references:/ nextgroup=paketReferencesStrictOrFalse contains=paketReferencesStrictOrFalse skipwhite
syn match paketReferencesStrictOrFalse /strict/ contained skipwhite
syn match paketReferencesStrictOrFalse /false/ contained skipwhite
hi def link paketReferencesStrictOrFalse Constant

syn match paketParameter /storage:/ nextgroup=paketStorage contains=paketStorage skipwhite
syn match paketStorage /none/ contained skipwhite
syn match paketStorage /packages/ contained skipwhite
syn match paketStorage /symlink/ contained skipwhite
hi def link paketStorage Constant

syn match paketParameter /content:/ nextgroup=paketContent contains=paketContent skipwhite
syn match paketContent /none/ contained skipwhite
syn match paketContent /once/ contained skipwhite
syn match paketContent /true/ contained skipwhite
hi def link paketContent Constant

syn match paketParameter /copy_content_to_output_dir:/ nextgroup=paketCopyContent contains=paketCopyContent skipwhite
syn match paketCopyContent /always/ contained skipwhite
syn match paketCopyContent /never/ contained skipwhite
syn match paketCopyContent /preserve_newest/ contained skipwhite
hi def link paketCopyContent Constant

syn match paketParameter /copy_local:/ nextgroup=paketBoolean contains=paketBoolean skipwhite
syn match paketParameter /import_targets:/ nextgroup=paketBoolean contains=paketBoolean skipwhite
syn match paketParameter /license_download:/ nextgroup=paketBoolean contains=paketBoolean skipwhite
syn match paketParameter /lowest_matching:/ nextgroup=paketBoolean contains=paketBoolean skipwhite
syn match paketParameter /generate_load_scripts:/ nextgroup=paketBoolean contains=paketBoolean skipwhite
syn match paketParameter /version_in_path:/ nextgroup=paketBoolean contains=paketBoolean skipwhite
syn match paketBoolean /true/ contained skipwhite
syn match paketBoolean /false/ contained skipwhite
hi def link paketBoolean Constant

syn match paketParameter /redirects:/ nextgroup=paketOnOffForce contains=paketOnOffForce skipwhite
syn match paketOnOffForce /on/ contained skipwhite
syn match paketOnOffForce /off/ contained skipwhite
syn match paketOnOffForce /force/ contained skipwhite
hi def link paketOnOffForce Constant

syn match paketParameter /strategy:/ nextgroup=paketMinMax contains=paketMinMax skipwhite
syn match paketMinMax /min/ contained skipwhite
syn match paketMinMax /max/ contained skipwhite
hi def link paketMinMax Constant


syn match paketKeyword /source/ nextgroup=paketSource contains=paketSource skipwhite

syn match paketSource /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/ contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\~' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\~/' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\~\(/[^\0./~]\+\)\+/\?' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\.' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\./' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\.\(/[^\0./~]\+\)\+/\?' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\.\.' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\.\./' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\.\.\(/[^\0./~]\+\)\+/\?' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource '\(/[^\0./~]\+\)\+/\?' contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource "[A-Za-z]:\\" contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource "[A-Za-z]:\(\\[^\0/~]\+\)\+\\\?" contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
syn match paketSource "\\\\[^\0\\~/]\+\(\\[^\0/~]\+\)\+\\\?" contained nextgroup=paketSourceParameter contains=paketSourceParameter skipwhite
hi def link paketSource          String

syn match paketSourceParameter /username:/ nextgroup=paketQuotedString contains=paketQuotedString contained skipwhite
syn match paketSourceParameter /password:/ nextgroup=paketQuotedString contains=paketQuotedString contained skipwhite

syn match paketQuotedString /"[^"]\+"/ contained nextgroup=paketSourceParameter skipwhite
hi def link paketQuotedString    String

syn match paketSourceParameter /authtype:/ nextgroup=paketAuthTypeValue contains=paketAuthTypeValue contained skipwhite
syn match paketAuthTypeValue /basic/ contained skipwhite
syn match paketAuthTypeValue /ntlm/ contained skipwhite
hi def link paketAuthTypeValue   Constant

hi def link paketSourceParameter Statement

syn match paketKeyword /external_lock/ nextgroup=paketLockSource contains=paketLockSource skipwhite
syn match paketLockSource '\~' contained skipwhite
syn match paketLockSource '\~/' contained skipwhite
syn match paketLockSource '\~\(/[^\0./~]\+\)\+/\?' contained skipwhite
syn match paketLockSource '\.' contained skipwhite
syn match paketLockSource '\./' contained skipwhite
syn match paketLockSource '\.\(/[^\0./~]\+\)\+/\?' contained skipwhite
syn match paketLockSource '\.\.' contained skipwhite
syn match paketLockSource '\.\./' contained skipwhite
syn match paketLockSource '\.\.\(/[^\0./~]\+\)\+/\?' contained skipwhite
syn match paketLockSource '\(/[^\0./~]\+\)\+/\?' contained skipwhite
syn match paketLockSource "[A-Za-z]:\\" contained skipwhite
syn match paketLockSource "[A-Za-z]:\(\\[^\0/~]\+\)\+\\\?" contained skipwhite
syn match paketLockSource "\\\\[^\0\\~/]\+\(\\[^\0/~]\+\)\+\\\?" contained skipwhite
hi def link paketLockSource String

syn keyword paketKeyword nuget nextgroup=paketPackageName skipwhite
syn match paketPackageName /[A-Za-z0-9_.]\+/ nextgroup=paketOperator,paketPrerelease,paketParameter contained skipwhite
hi def link paketPackageName Identifier

syn match paketOperator '>' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '@>' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '!>' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '<' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '@<' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '!<' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '=' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '@=' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '!=' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '>=' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '@>=' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '!>=' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '<=' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '@<=' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '!<=' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '==' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '@==' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '!==' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '\~>' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '@\~>' skipwhite contained nextgroup=paketVersion contains=paketVersion
syn match paketOperator '!\~>' skipwhite contained nextgroup=paketVersion contains=paketVersion
hi def link paketOperator Operator

syn match paketPrerelease /prerelease/ nextgroup=paketParameter,paketOperator contained skipwhite
hi def link paketPrerelease Constant


syn match paketVersion /\d\+\(\.\d\+\)*\(-[a-z]\+\d*\)\?/ nextgroup=paketParameter contained
hi def link paketVersion Constant

syn keyword paketKeyword group nextgroup=paketGroup skipwhite
syn match paketGroup excludenl /\w\+/ contained skipwhite
hi def link paketGroup Identifier

hi def link paketKeyword   Statement
hi def link paketParameter Statement

syn match paketComment /^\/\/.*$/
syn match paketComment /^#.*$/
hi def link paketComment Comment

let b:current_syntax = "paketdeps"

