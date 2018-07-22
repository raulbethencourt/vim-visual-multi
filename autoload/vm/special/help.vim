"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings help
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! s:dict()

  let regions   = ['Find Under',                        'Find Prev',
                  \'Select All',                        'Find Next',
                  \'Start Regex Search',                'Goto Prev',
                  \'Star',                              'Goto Next',
                  \'Hash',                              'q Skip',
                  \'Remove Last Region',                'Remove Region',
                  \'Select Line Down',                  'Skip Region',
                  \'Select Line Up',                    'Find I Word',
                  \'Find A Word',                       'Find I Whole Word',
                  \]

  let cursors   = ['Add Cursor At Pos',                 'Select Cursor Down',
                  \'Add Cursor At Word',                'Select Cursor Up',
                  \'Add Cursor Down',                   'Merge To Eol',
                  \'Add Cursor Up',                     'Merge To Bol',
                  \]

  let visual    = ['Find Subword Under',                'Visual All',
                  \'Visual Add',                        'Visual Find',
                  \'Visual Subtract',                   'Visual Star',
                  \'Visual Cursors',                    'Visual Hash',
                  \'Find A Subword',                    'Find A Whole Subword',
                  \'Visual Regex',
                  \]

  let operators = ['Select Operator',                   'Select All Operator',
                  \'Find Operator',                     '',
                  \]

  let commands  = ['Run Normal',                        'Align',
                  \'Run Last Normal',                   'Align Char',
                  \'Run Visual',                        'Align Regex',
                  \'Run Last Visual',                   'Numbers',
                  \'Run Ex',                            'Numbers Append',
                  \'Run Last Ex',                       'Zero Numbers',
                  \'Run Macro',                         'Zero Numbers Append',
                  \'Run Dot',                           'Shrink',
                  \'Surround',                          'Enlarge',
                  \'Transpose',                         'Merge Regions',
                  \'Increase',                          'Duplicate',
                  \'Decrease',                          'Split Regions',
                  \]

  let mouse     = ['Mouse Cursor',                      '',
                  \'Mouse Word',                        '',
                  \'Mouse Column',                      '',
                  \]

  let tools     = ['Show Registers',                    'Rewrite Last Search',
                  \'Search Menu',                       'Tools Menu',
                  \'Case Conversion Menu',              'Toggle Debug',
                  \]

  let special   = ['Toggle Mappings',                   'Toggle Block',
                  \'Switch Mode',                       'Toggle Only This Region',
                  \'Case Setting',                      'Toggle Whole Word',
                  \'Invert Direction',                  'Toggle Multiline',
                  \]

  let edit      = ['D',                       'Y',
                  \'x',                       'X',
                  \'J',                       '~',
                  \'Del',                     'Dot',
                  \'a',                       'A',
                  \'i',                       'I',
                  \'o',                       'O',
                  \'c',                       'C',
                  \'Yank',                    'Replace',
                  \'Delete',                  'Replace Pattern',
                  \'p Paste Regions',         'p Paste Normal',
                  \'P Paste Regions',         'P Paste Normal',
                  \]

  let insert    = ['I Arrow w',               'I Arrow b',
                  \'I Arrow W',               'I Arrow B',
                  \'I Arrow ge',              'I Arrow e',
                  \'I Arrow gE',              'I Arrow E',
                  \'I Left Arrow',            'I Right Arrow',
                  \'I Up Arrow',              'I Down Arrow',
                  \'I Return',                'I BS',
                  \'I Paste',                 'I CtrlW',
                  \'I CtrlD',                 'I Del',
                  \'I CtrlA',                 'I CtrlE',
                  \'I CtrlB',                 'I CtrlF',
                  \]

  let arrows    = []
  let others    = []

  for p in sort(keys(g:VM.help))
    if index(regions, p) >= 0
    elseif index(cursors, p) >= 0
    elseif index(visual, p) >= 0
    elseif index(operators, p) >= 0
    elseif index(commands, p) >= 0
    elseif match(g:VM.help[p], '\-Up\|\-Down\|\-Left\|\-Right') >= 0
      call add(arrows, p)
    elseif index(tools, p) >= 0
    elseif index(insert, p) >= 0
    elseif index(edit, p) >= 0
    elseif index(special, p) >= 0
    else
      call add(others, p)
    endif
  endfor

  return {'regions': regions, 'cursors': cursors, 'visual': visual, 'operators': operators, 'commands': commands, 'tools': tools, 'mouse': mouse, 'arrows': arrows, 'insert': insert, 'edit': edit, 'special': special, 'others': others}
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:Pad = { t, n -> b:VM_Selection.Funcs.pad(t, n) }

fun! s:Txt(i, m)
  let p = match(a:m, '"') >= 0? 21 : 20
  let p = match(a:m, '\') >= 0? p+1 : p
  return (a:i%2? 'echon "' : 'echo "').s:Pad(escape(a:m, '"\'), p).'"'
endfun


fun! vm#special#help#show()

  let _  = "=========="
  let __ = _._._._._._._._._._._._._._._._._._
  let sp = '                                                                                 '

  let groups = [
        \["\n".__."\n"."   Regions        ".sp."\n\n", "regions"],
        \["\n".__."\n"."   Cursors        ".sp."\n\n", "cursors"],
        \["\n".__."\n"."   Operators      ".sp."\n\n", "operators"],
        \["\n".__."\n"."   Visual         ".sp."\n\n", "visual"],
        \["\n".__."\n"."   Mouse          ".sp."\n\n", "mouse"],
        \["\n".__."\n"."   Arrows         ".sp."\n\n", "arrows"],
        \["\n".__."\n"."   Special        ".sp."\n\n", "special"],
        \["\n".__."\n"."   Commands       ".sp."\n\n", "commands"],
        \["\n".__."\n"."   Tools          ".sp."\n\n", "tools"],
        \["\n".__."\n"."   Edit           ".sp."\n\n", "edit"],
        \["\n".__."\n"."   Insert         ".sp."\n\n", "insert"],
        \["\n".__."\n"."   All Others     ".sp."\n\n", "others"],
        \]

  echohl Special    | echo "1. "          | echohl Type | echon "Regions, Cursors, Operators, Visual"
  echohl Special    | echo "2. "          | echohl Type | echon "Mouse, Arrows"
  echohl Special    | echo "3. "          | echohl Type | echon "Special, Commands, Menus"
  echohl Special    | echo "4. "          | echohl Type | echon "Edit, Insert, Others"
  echohl WarningMsg | echo "\nEnter an option > "       | let ask = nr2char(getchar())      | echohl None

  if ask == '1'     | redraw! | let show_groups = groups[:3]
  elseif ask == '2' | redraw! | let show_groups = groups[4:5]
  elseif ask == '3' | redraw! | let show_groups = groups[6:8]
  elseif ask == '4' | redraw! | let show_groups = groups[-3:-1]
  else              | return  | endif

  let D = s:dict()

  for g in show_groups
    echohl WarningMsg | echo g[0] | echohl None
    let dict_key = g[1]
    let i = 0
    "iterate s:dict chosen groups and print keys / desctiptions / notes
    for plug in D[dict_key]
      if !has_key(g:VM.help, plug) | continue | endif
      let Map  = g:VM.help[plug]
      let Desc = s:plugs[plug][0]
      let Note = s:plugs[plug][1]
      echohl Special | exe s:Txt(i, Map)
      echohl Type    | echon s:Pad(Desc, 25)
      echohl None    | echon s:Pad(Note, 50)
      let i += 1
    endfor
    echo "\n"
  endfor
endfun

let s:plugs = {
      \"Erase Regions":           ["Erase Regions",              ""],
      \"Add Cursor At Pos":       ["Add Cursor At Position",     "create a cursor at current position"],
      \"Add Cursor At Word":      ["Add Cursor At Word",         "create a cursor at current word, adding a pattern"],
      \"Start Regex Search":      ["Start Regex Search",         "add regions with a regex pattern"],
      \"Select All":              ["Select All",                 ""],
      \"Add Cursor Down":         ["Add Cursor Down",            "in cursor mode"],
      \"Add Cursor Up":           ["Add Cursor Up",              "in cursor mode"],
      \"Visual Regex":            ["Find By Regex",              "add regions with regex in visual selection"],
      \"Visual All":              ["Select All",                 "subwords accepted"],
      \"Visual Add":              ["Visual Add",                 "create a region from visual selection"],
      \"Visual Find":             ["Visual Find",                "find current patterns in visual selection"],
      \"Visual Cursors":          ["Visual Cursors",             "create cursors along visual selection"],
      \"Select Cursor Down":      ["Select Cursor Down",         "in extend mode"],
      \"Select Cursor Up":        ["Select Cursor Up",           "in extend mode"],
      \"Select j":                ["Extend Down",                ""],
      \"Select k":                ["Extend Up",                  ""],
      \"Select l":                ["Extend Right",               ""],
      \"Select h":                ["Extend Left",                ""],
      \"Select w":                ["Extend (w)",                 ""],
      \"Select b":                ["Extend (b)",                 ""],
      \"Select Line Down":        ["Select Line Down",           "like Visual Line"],
      \"Select Line Up":          ["Select Line Up",             "like Visual Line"],
      \"Select E":                ["Extend (E)",                 ""],
      \"Select BBW":              ["Extend (BBW)",               ""],
      \"Select e":                ["Extend (e)",                 ""],
      \"Select ge":               ["Extend (ge)",                ""],
      \"Move Right":              ["Move Right",                 "shift the selection(s) to the right"],
      \"Move Left":               ["Move Left",                  "shift the selection(s) to the left"],
      \"Find Under":              ["Select Inner Whole Word",    "whole word, or expand word under cursors"],
      \"Find Subword Under":      ["Select Subword",             "without word boundaries"],
      \"Find I Word":             ["Select Inner Word",          "without word boundaries"],
      \"Find A Word":             ["Select Around Word",         ""],
      \"Find I Whole Word":       ["Select Inner Whole Word",    ""],
      \"Find A Subword":          ["Select A Subword",           ""],
      \"Find A Whole Subword":    ["Select A Whole Subword",     ""],
      \"Mouse Cursor":            ["Mouse Cursor",               "create a cursor at position"],
      \"Mouse Word":              ["Mouse Word",                 "select word"],
      \"Mouse Column":            ["Mouse Column",               "create a column of cursors"],
      \"Find Next":               ["Find next",                  "always downwards"],
      \"Find Prev":               ["Find previous",              "always upwards"],
      \"Goto Next":               ["Goto Next",                  ""],
      \"Goto Prev":               ["Goto Prev",                  ""],
      \"Toggle Mappings":         ["Toggle Mappings",            "disable VM mappings, except Space and Escape"],
      \"Exit VM":                 ["Exit VM",                    ""],
      \"Switch Mode":             ["Switch Mode",                "toggle cursor/extend mode"],
      \"Toggle Block":            ["Toggle Block Mode",          ""],
      \"Toggle Only This Region": ["Toggle Only This Region",    "lets you modify a region at a time"],
      \"Skip Region":             ["Skip Region",                "and find next in the current direction"],
      \"q Skip":                  ["Skip Region",                "and find next in the current direction"],
      \"Invert Direction":        ["Invert Direction",           "as 'o' in visual mode"],
      \"Remove Region":           ["Remove Region",              "and go back to previous"],
      \"Remove Last Region":      ["Remove Last Region",         "removes the bottom-most region"],
      \"Star":                    ["Star",                       "select inner word, case sensitive"],
      \"Hash":                    ["Hash",                       "select around word, case sensitive"],
      \"Visual Star":             ["Visual Star",                "select inner (sub)word, case sensitive"],
      \"Visual Hash":             ["Visual Hash",                "select around (sub)word, case sensitive"],
      \"Merge To Eol":            ["Merge to EOL",               "collapse cursors to end of line"],
      \"Merge To Bol":            ["Merge to BOL",               "collapse cursors to indent level"],
      \"Select Operator":         ["Select Operator",            "accepts motions and text objects"],
      \"Select All Operator":     ["Select All Operator",        "applies the select operator to all cursors"],
      \"Find Operator":           ["Find Operator",              "matches patterns in motion/text object"],
      \"This Motion h":           ["Extend Left This Region",    ""],
      \"This Motion l":           ["Extend Right This Region",   ""],
      \"This Select h":           ["Extend Left This Region",    "will create a new region if there is none"],
      \"This Select l":           ["Extend Right This Region",   "will create a new region if there is none"],
      \"Tools Menu":              ["Tools Menu",                 ""],
      \"Show Help":               ["Show Help",                  ""],
      \"Show Registers":          ["Show Registers",             ""],
      \"Toggle Debug":            ["Toggle Debug",               ""],
      \"Case Setting":            ["Change Case Setting",        "cycle case settings (smart, ignore, noignore)"],
      \"Toggle Whole Word":       ["Toggle Whole Word",          "toggle word boundaries for most recent pattern"],
      \"Case Conversion Menu":    ["Case Conversion Menu",       ""],
      \"Search Menu":             ["Search Menu",                ""],
      \"Rewrite Last Search":     ["Rewrite Last Search",        "update last search pattern to match current region"],
      \"Toggle Multiline":        ["Toggle Multiline",           "will force one region per line, when disabling"],
      \"Surround":                ["Surround",                   ""],
      \"Merge Regions":           ["Merge Regions",              ""],
      \"Transpose":               ["Transpose",                  ""],
      \"Duplicate":               ["Duplicate",                  ""],
      \"Align":                   ["Align at Column",            "simple alignment at highest cursors column"],
      \"Split Regions":           ["Split Regions",              ""],
      \"Visual Subtract":         ["Visual Subtract",            "subtract visual selection from regions"],
      \"Run Normal":              ["Run Normal Command",         ""],
      \"Run Last Normal":         ["Run Last Normal Command",    ""],
      \"Run Visual":              ["Run Visual Command",         ""],
      \"Run Last Visual":         ["Run Last Visual Command",    ""],
      \"Run Ex":                  ["Run Ex Command",             ""],
      \"Run Last Ex":             ["Run Last Ex Command",        ""],
      \"Run Macro":               ["Run Macro at Cursors",       ""],
      \"Run Dot":                 ["Run Dot at Cursors",         ""],
      \"Align Char":              ["Align by Character(s)",      "accepts count for multiple characters"],
      \"Align Regex":             ["Align by Regex",             ""],
      \"Numbers":                 ["Prepend Numbers",            "with optional separator, count from 1"],
      \"Numbers Append":          ["Append Numbers",             "with optional separator, count from 1"],
      \"Zero Numbers":            ["Prepend Numbers from 0",     "with optional separator, count from 0"],
      \"Zero Numbers Append":     ["Append Numbers from 0",      "with optional separator, count from 0"],
      \"Shrink":                  ["Shrink",                     "reduce selection(s) width by 1 from the sides"],
      \"Enlarge":                 ["Enlarge",                    "increase selection(s) width by 1 from the sides"],
      \"I Arrow w":               ["(I) w",                      "move as by motion"],
      \"I Arrow b":               ["(I) b",                      "move as by motion"],
      \"I Arrow W":               ["(I) W",                      "move as by motion"],
      \"I Arrow B":               ["(I) B",                      "move as by motion"],
      \"I Arrow ge":              ["(I) ge",                     "move as by motion"],
      \"I Arrow e":               ["(I) e",                      "move as by motion"],
      \"I Arrow gE":              ["(I) gE",                     "move as by motion"],
      \"I Arrow E":               ["(I) E",                      "move as by motion"],
      \"I Left Arrow":            ["(I) Left",                   ""],
      \"I Right Arrow":           ["(I) Right",                  ""],
      \"I Up Arrow":              ["(I) Up",                     "currently moves left"],
      \"I Down Arrow":            ["(I) Down",                   "currently moves right"],
      \"I Return":                ["(I) Return",                 ""],
      \"I BS":                    ["(I) Backspace",              ""],
      \"I Paste":                 ["(I) Paste",                  "using VM unnamed register"],
      \"I CtrlW":                 ["(I) CtrlW",                  "as ctrl-w"],
      \"I CtrlD":                 ["(I) CtrlD",                  "same as delete"],
      \"I Del":                   ["(I) Del",                    ""],
      \"I CtrlA":                 ["(I) CtrlA",                  "moves to the beginning of the line"],
      \"I CtrlE":                 ["(I) CtrlE",                  "moves to the end of the line"],
      \"I CtrlB":                 ["(I) CtrlB",                  "same as left arrow"],
      \"I CtrlF":                 ["(I) CtrlF",                  "same as right arrow"],
      \"D":                       ["D",                          ""],
      \"Y":                       ["Y",                          ""],
      \"x":                       ["x",                          ""],
      \"X":                       ["X",                          ""],
      \"J":                       ["J",                          ""],
      \"~":                       ["~",                          ""],
      \"Del":                     ["Del",                        ""],
      \"Dot":                     ["Dot command",                "cursor mode only"],
      \"Increase":                ["Increase Numbers",           "same as ctrl-a at cursors"],
      \"Decrease":                ["Decrease Numbers",           "same as ctrl-x at cursors"],
      \"a":                       ["a",                          ""],
      \"A":                       ["A",                          ""],
      \"i":                       ["i",                          ""],
      \"I":                       ["I",                          ""],
      \"o":                       ["o",                          ""],
      \"O":                       ["O",                          ""],
      \"c":                       ["c",                          ""],
      \"C":                       ["C",                          ""],
      \"Delete":                  ["Delete",                     "both vim and VM registers"],
      \"Replace":                 ["Replace",                    "just as 'r'"],
      \"Replace Pattern":         ["Replace Pattern",            "regex substitution in all regions"],
      \"p Paste Regions":         ["p Paste",                    "both vim and VM registers"],
      \"P Paste Regions":         ["P Paste",                    "both vim and VM registers"],
      \"p Paste Normal":          ["p Paste [vim]",              "force pasting from vim register"],
      \"P Paste Normal":          ["P Paste [vim]",              "force pasting from vim register"],
      \"Yank":                    ["Yank",                       "both vim and VM registers"],
      \}
