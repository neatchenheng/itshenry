" Sean Reifschneider's vimrc file (by popular demand)
set autoindent
set backspace=1
set timeoutlen=3000
set ttimeoutlen=50
set wildmenu
set wildmode=longest:full
set scrolloff=1
set noruler
set exrc
set spelllang=en_us
" set spellfile=/home/jafo/vim/spell/generic.en.add
set synmaxcol=600
highlight SpellBad ctermfg=NONE ctermbg=NONE cterm=underline,bold
highlight SpellCap ctermfg=NONE ctermbg=NONE cterm=underline,bold
highlight SpellLocal ctermfg=NONE ctermbg=NONE cterm=underline,bold
highlight MatchParen cterm=bold ctermfg=NONE ctermbg=NONE

set t_ti= t_te=    "  Do not change to alternate xterm screen

set ignorecase smartcase

set smarttab tabstop=8 shiftwidth=3 expandtab list textwidth=75
set listchars=tab:>-,trail:-

if !has("compatible")
   set foldmethod=marker
   filetype plugin indent on
   set cinoptions=}1s
   autocmd FileType c set tabstop=3 shiftwidth=3 softtabstop=0 smarttab noexpandtab nolist textwidth=0
   autocmd FileType cpp set tabstop=3 shiftwidth=3 softtabstop=0 smarttab noexpandtab nolist textwidth=0
   autocmd FileType java set tabstop=3 shiftwidth=3 softtabstop=0 smarttab noexpandtab nolist textwidth=0
   autocmd FileType python set tabstop=3 shiftwidth=3 softtabstop=0 smarttab noexpandtab nolist textwidth=0
   autocmd FileType php set tabstop=3 shiftwidth=3 softtabstop=0 smarttab noexpandtab nolist textwidth=0
   autocmd FileType sh set tabstop=3 shiftwidth=3 softtabstop=0 smarttab noexpandtab nolist textwidth=0
   autocmd FileType make set tabstop=3 shiftwidth=3 softtabstop=0 smarttab noexpandtab nolist textwidth=0
   autocmd BufRead,BufNewFile /tmp/mutt-* source $HOME/.vimrc-mutt
   autocmd FileType dns set textwidth=0 nolist
   autocmd FileType dns map S :python updateDnsSerial()^M
   "autocmd BufNewFile  *.py  0r ~/vim/skeleton.py

   "Python stuff
   "pyfile ~/vim/vim.py
   map ( :python pythonblockStart()^M
   map ) :python pythonblockEnd()^M
   map C :set cursorcolumn! cursorline!^M

   "  Set indentation automatically
   autocmd BufRead * python setIndentation()
endif

set background=dark
highlight PreProc ctermfg=5 cterm=bold    "cyan
highlight Comment ctermfg=9         "bright red
highlight String ctermfg=7       "dark white
highlight Normal guibg=Black guifg=White

" pyblock.vim
map ( :python pythonblockFind(forward = 0)^M
map ) :python pythonblockFind()^M

python << EOF
def countIndent(line):
   i = 0
   for s in line:
      if s != ' ' and s != '\t': return(i)
      i = i + 1
   return(0)

def isEmptyLine(line):
   return(not line.strip())

def pythonblockNonblank(lineno, forward = 1):
   import vim
   cb = vim.current.buffer
   col = vim.current.window.cursor[1]

   end, increment = ( 0, -1 )
   if forward == 1: end, increment = ( len(cb), 1 )

   for i in xrange(lineno, end, increment):
      cline = cb[i - 1]
      if not isEmptyLine(cline):
         if i >= len(cb): i = len(cb) - 1
         if i < 1: i = 1
         vim.current.window.cursor = ( i, col )
         return()

def pythonblockFind(forward = 1):
   import vim

   cb = vim.current.buffer
   lineno, col = vim.current.window.cursor
   cline = cb[lineno - 1]
   cIndent = countIndent(cline)

   end, increment = ( 0, -1 )
   if forward == 1: end, increment = ( len(cb), 1 )

   for i in xrange(lineno, end, increment):
      cline = cb[i - 1]
      if isEmptyLine(cline): continue
      if countIndent(cline) < cIndent:
         if forward == 1: return(pythonblockNonblank(i - 1, not forward))
         return(pythonblockNonblank(i + 1, not forward))

   if forward == 1: vim.current.window.cursor = ( len(cb) - 1, col )
   else: vim.current.window.cursor = ( 1, col )
EOF

" dns.vimrc
autocmd FileType dns map S :python updateDnsSerial()^M

python << EOF
def updateDnsSerial():
   import re, time, vim, string

   maxSearch = 20

   cb = vim.current.buffer
   foundSoa = 0
   for i in xrange(0, min(maxSearch, len(cb))):
      line = cb[i]
      if foundSoa:
         #  look for serial
         rx = re.match(r'^\s*(\d+).*', line)
         if not rx:
            print 'Unable to find Serial'
            return
         serial = rx.group(1)

         #  generate new serial
         now = time.time()
         today = time.strftime('%Y%m%d00', time.localtime(now))
         todayVal = long(today)
         serialVal = long(serial)
         if todayVal <= serialVal: todayVal = serialVal + 1

         #  update serial
         cb[i] = string.replace(line, serial, '%d' % todayVal)

         #  display update string
         print 'Updated serial from "%s" to "%d"' % ( serial, todayVal )
         break
      if re.match(r'^@\s+IN\s+SOA\s+', line): foundSoa = 1
EOF

" indent.vimrc
autocmd BufRead * python setIndentation()

python << EOF
def setIndentation():
   import vim
   maxSearch = 1000     #  max number of lines to search through

   indentSpaces = None
   cb = vim.current.buffer
   indentCount = { ' ' : 0, '\t' : 0 }
   justSawDefOrClassLine = 0
   for i in xrange(0, min(maxSearch, len(cb))):
      line = cb[i]
      if not line: continue

      #  count spaces after a class or def line
      if justSawDefOrClassLine:
         justSawDefOrClassLine = 0
         if line[0] == ' ':
            indentSpaces = 0
            for c in line:
               if c != ' ': break
               indentSpaces = indentSpaces + 1
      if line[:4] == 'def ' or line[:6] == 'class ':
         justSawDefOrClassLine = 1

      #  add to tab versus space count
      if line[0] in ' \t':
         indentCount[line[0]] = indentCount.get(line[0], 0) + 1

   #  more lines started with space
   if indentCount[' '] > indentCount['\t']:
      vim.command('set smarttab tabstop=8 expandtab')
      if indentSpaces:
         vim.command('set ts=%d sw=%d' % ( indentSpaces, indentSpaces ))

   #  more lines started with tab
   else:
      vim.command('set softtabstop=3 ts=3 sw=3')
EOF
