let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~\.vim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +10 ~\AppData\Local\nvim\coc-settings.json
badd +35 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\services\durationLimits.service.js
badd +6 term://.//28912:pwsh.exe
badd +6 term://.//44024:pwsh.exe
badd +75 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\directives\datePicker.directive.js
badd +1 ~\AppData\Local\nvim\init.vim
badd +15 plugins.vim
badd +1 C:\Users\LSYMIN~1\AppData\Local\Temp\coc-nvim-33748.log
badd +3226 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\controllers\offerCreate.js
badd +1 functions\number_toggle.vim
badd +1 general.vim
badd +488 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Views\Shared\Partials\OfferEdit.cshtml
badd +223 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\services\dateTime.service.js
badd +1 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\__vista__
badd +1 term://.//29488:pwsh.exe
badd +546 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Highlight\ test
badd +0 C:/git/vouchercloud-idl/IDL.Web.ControlCloud/Content/scripts/app.js
badd +1 C:/git/vouchercloud-idl/IDL.Web.ControlCloud/Content/scripts/services/processHTML.service.js
badd +48 ~/.vim/plugin_settings/Defx.vim
badd +23 ~/dotfiles/nvim/.vim/mappings.vim
badd +1 ~/.vim/.netrwhist
badd +42 ~/.vim/ui.vim
badd +26 ~/.vim/mappings.vim
argglobal
silent! argdel *
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
enew
file [defx]\ default-0
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
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
