"""""""" clang formatting
let g:clang_format#style_options = {
      \ "AccessModifierOffset": -2,
      \ "ConstructorInitializerIndentWidth": 4,
      \ "AlignEscapedNewlinesLeft": "false",
      \ "AlignTrailingComments": "true",
      \ "AllowAllParametersOfDeclarationOnNextLine": "true",
      \ "AllowShortIfStatementsOnASingleLine": "false",
      \ "AllowShortLoopsOnASingleLine": "false",
      \ "AlwaysBreakTemplateDeclarations": "false",
      \ "AlwaysBreakBeforeMultilineStrings": "false",
      \ "BreakBeforeBinaryOperators": "false",
      \ "BreakBeforeTernaryOperators": "true",
      \ "BreakConstructorInitializersBeforeComma": "false",
      \ "BinPackParameters": "true",
      \ "ColumnLimit": 80,
      \ "ConstructorInitializerAllOnOneLineOrOnePerLine": "false",
      \ "DerivePointerBinding": "false",
      \ "ExperimentalAutoDetectBinPacking": "false",
      \ "IndentCaseLabels": "false",
      \ "MaxEmptyLinesToKeep": 1,
      \ "NamespaceIndentation": "None",
      \ "ObjCSpaceBeforeProtocolList": "true",
      \ "PenaltyBreakBeforeFirstCallParameter": 19,
      \ "PenaltyBreakComment": 60,
      \ "PenaltyBreakString": 1000,
      \ "PenaltyBreakFirstLessLess": 120,
      \ "PenaltyExcessCharacter": 1000000,
      \ "PenaltyReturnTypeOnItsOwnLine": 60,
      \ "PointerBindsToType": "false",
      \ "SpacesBeforeTrailingComments": 1,
      \ "Cpp11BracedListStyle": "false",
      \ "Standard": "C++11",
      \ "IndentWidth": 2,
      \ "TabWidth": 8,
      \ "UseTab": "Never",
      \ "BreakBeforeBraces": "Attach",
      \ "IndentFunctionDeclarationAfterType": "false",
      \ "SpacesInParentheses": "false",
      \ "SpacesInAngles":  "false",
      \ "SpaceInEmptyParentheses": "false",
      \ "SpacesInCStyleCastParentheses": "false",
      \ "SpaceAfterControlStatementKeyword": "true",
      \ "SpaceBeforeAssignmentOperators": "true",
      \ "ContinuationIndentWidth": 4,}

"" run clang format  when selecting and pressing equal
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer>= :ClangFormat<CR>

" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)

 " Toggle auto formatting:
nmap <Leader>><Leader>ff :ClangFormatAutoToggle<CR>
