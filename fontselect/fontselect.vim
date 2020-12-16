" This plugin allows to choose the best font for your Vim.
" You can change font on the fly and change its size.
" =============================================================================
" Installation
" Several fonts that can be in the system
" Comment any line with fonts you don't have or don't want to
" or install that fonts
let s:myfontlist = ["Droid Sans Mono Slashed"]
let s:myfontlist+=['IBM Plex Mono']
let s:myfontlist+=['IBM Plex Mono Text']
let s:myfontlist+=['IBM Plex Mono Medium']
let s:myfontlist+=['IBM Plex Mono SemiBold']
let s:myfontlist+=['IBM Plex Mono Light']
let s:myfontlist+=['IBM Plex Mono ExtraLight']
let s:myfontlist+=['IBM Plex Mono Thin']
let s:myfontlist+=['Fira Mono']
let s:myfontlist+=['JetBrains Mono']
let s:myfontlist+=['JetBrains Mono Medium']
let s:myfontlist+=['JetBrains Mono Light']
let s:myfontlist+=['JetBrains Mono Extra Bold']
let s:myfontlist+=['JetBrains Mono ExtraLight']
let s:myfontlist+=['JetBrains Mono Semi Light']
let s:myfontlist+=['Consolas']
let s:myfontlist+=['PT Mono']
let s:myfontlist+=['Ubuntu Mono']
let s:myfontlist+=['DejaVu Sans Mono']
let s:myfontlist+=['Hack']
let s:myfontlist+=['Roboto Mono']
let s:myfontlist+=['Roboto Mono Medium']
let s:myfontlist+=['Roboto Mono Light']
let s:myfontlist+=['Roboto Mono Thin']
let s:myfontlist+=['InconsolataCyr']
let s:myfontlist+=['Input Mono']
let s:myfontlist+=['InputMono Black']
let s:myfontlist+=['InputMono ExLight']
let s:myfontlist+=['InputMono Light']
let s:myfontlist+=['InputMono Medium']
let s:myfontlist+=['InputMono Thin']
let s:myfontlist+=['Input Mono Compressed']
let s:myfontlist+=['InputMonoCompressed Black']
let s:myfontlist+=['InputMonoCompressed ExLight']
let s:myfontlist+=['InputMonoCompressed Light']
let s:myfontlist+=['InputMonoCompressed Medium']
let s:myfontlist+=['InputMonoCompressed Thin']
let s:myfontlist+=['Input Mono Condensed']
let s:myfontlist+=['InputMonoCondensed Black']
let s:myfontlist+=['InputMonoCondensed ExLight']
let s:myfontlist+=['InputMonoCondensed Light']
let s:myfontlist+=['InputMonoCondensed Medium']
let s:myfontlist+=['InputMonoCondensed Thin']
let s:myfontlist+=['Input Mono Narrow']
let s:myfontlist+=['InputMonoNarrow Black']
let s:myfontlist+=['InputMonoNarrow ExLight']
let s:myfontlist+=['InputMonoNarrow Light']
let s:myfontlist+=['InputMonoNarrow Medium']
let s:myfontlist+=['InputMonoNarrow Thin']
let s:myfontlist+=['Iosevka']
let s:myfontlist+=['Iosevka Medium']
let s:myfontlist+=['Iosevka Semibold']
let s:myfontlist+=['iosevka Nerd Font Mono']
" Here you can add your own fonts in the same manner. 
" These fonts must be installed in your system before you add them here.



let s:mycurrentfontindex = -1					" Counter for current position in font list
let s:myfontlistlen = len(s:myfontlist) - 1			" Remembering length of the font list to make things universal
let s:mysize = 16						" Set initial font size
let s:ShowFontNameinStatusLine = 0				" Flag for showing or not font name in status line
let s:SavedStatusLine = ''					" For saving previous status line when showing font name in it. 

" Allying new font settings to Vim.
" The Vim screen is updated with new font and size.
function RedrawScreen()
	"with help of https://www.reddit.com/r/neovim/comments/9n7sja/liga_source_code_pro_is_not_a_fixed_pitch_font/
	let s:myguifont=join([s:myfontlist[s:mycurrentfontindex],join(["h",s:mysize], "")], ":")
	execute 'GuiFont! '. s:myguifont
endfunction

" Funtion reads next font name from font list
" If end of list is reached, we will start from the beginning
" After reading next font the screen is redrawed
function ChangeFont()
	let s:mycurrentfontindex = s:mycurrentfontindex + 1
	if s:mycurrentfontindex ># s:myfontlistlen
		let s:mycurrentfontindex = 0
	endif
	call RedrawScreen()
endfunction

" Changes size of the font
" After changing size the scree in redrawed
function ChangeSize(myincrement)
	let s:mysize = s:mysize + a:myincrement
	call RedrawScreen()
endfunction

" Changes status line to display font name
" Also previous status line is saved
function AddFontNametoStatusLine()
	let s:SavedStatusLine = &statusline
	let &statusline = 'Font: %{trim(execute("GuiFont"))}'
endfunction

" Restores original status line, saved previously 
function RemoveFontNamefromStatusLine()
	let &statusline = s:SavedStatusLine
endfunction

" Turns on and off displaying font name in status line
function SwitchStatusLine()
	if  s:ShowFontNameinStatusLine
		let s:ShowFontNameinStatusLine = 0
		call RemoveFontNamefromStatusLine()
	else
		let s:ShowFontNameinStatusLine = 1
		call AddFontNametoStatusLine()
	endif
endfunction

" Press leader key and df (_d_isplay _f_ont) to show font name
" Press leader key and df again to return original status line
nnoremap <leader>df :call SwitchStatusLine()<enter>

" Press leade key and cf (_c_hange _f_ont) to change font by another in the list
nnoremap <leader>cf :call ChangeFont()<enter>

" Press leader key and - to decrease font size by 1
nnoremap <leader>- :call ChangeSize(-1)<enter>

" Press leader key and - to increase font size by 1
nnoremap <leader>+ :call ChangeSize(+1)<enter>
