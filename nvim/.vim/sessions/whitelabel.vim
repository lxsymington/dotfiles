let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd C:\git\vouchercloud-idl\IDL.Web.WhiteLabel
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\controllers\AdvertCreate.js
badd +45 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\directives\datePicker.directive.js
badd +10 term://.//38504:pwsh.exe
badd +0 term://.//19092:pwsh.exe
badd +22 Content\src\style\themes\mumsnet\sections\_alpha.scss
badd +26 Content\src\style\placeholders\sections\_alpha.scss
badd +1 ~\AppData\Local\nvim\init.vim
badd +9 ~\.vim\plugin_settings\NerdTree.vim
badd +0 ~\AppData\Local\nvim\ginit.vim
badd +1 Content\src\style\placeholders\sections\_alternativeoffers.scss
badd +26 Content\src\style\themes\mumsnet\sections\_alternativeoffers.scss
badd +8 Content\src\style\themes\mumsnet\sections\_base.scss
badd +55 Content\src\style\placeholders\sections\_banner.scss
badd +28 Content\src\style\themes\mumsnet\sections\banner\_default.scss
badd +0 Content\src\style\placeholders\sections\_carousel.scss
badd +109 Content\src\style\themes\mumsnet\sections\banner\_hero.scss
badd +0 Content\src\style\themes\mumsnet\sections\_carousel.scss
argglobal
silent! argdel *
edit Content\src\style\placeholders\sections\_carousel.scss
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 55 + 34) / 68)
exe 'vert 1resize ' . ((&columns * 182 + 182) / 365)
exe '2resize ' . ((&lines * 55 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 182 + 182) / 365)
exe '3resize ' . ((&lines * 10 + 34) / 68)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 50 - ((49 * winheight(0) + 27) / 55)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
50
normal! 07|
wincmd w
argglobal
if bufexists('Content\src\style\themes\mumsnet\sections\_carousel.scss') | buffer Content\src\style\themes\mumsnet\sections\_carousel.scss | else | edit Content\src\style\themes\mumsnet\sections\_carousel.scss | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 24 - ((23 * winheight(0) + 27) / 55)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
24
normal! 04|
lcd C:\git\vouchercloud-idl\IDL.Web.ControlCloud
wincmd w
argglobal
if bufexists('term://.//19092:pwsh.exe') | buffer term://.//19092:pwsh.exe | else | edit term://.//19092:pwsh.exe | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 32 - ((9 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
32
normal! 0
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 55 + 34) / 68)
exe 'vert 1resize ' . ((&columns * 182 + 182) / 365)
exe '2resize ' . ((&lines * 55 + 34) / 68)
exe 'vert 2resize ' . ((&columns * 182 + 182) / 365)
exe '3resize ' . ((&lines * 10 + 34) / 68)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
