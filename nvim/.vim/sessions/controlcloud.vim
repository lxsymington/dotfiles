let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd C:\git\vouchercloud-idl
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ~\AppData\Local\nvim\init.vim
badd +51 ~\.vim\plugin_settings\ale.vim
badd +1 ~\dotfiles\nvim\.vimrc
badd +1 IDL.Web.Vc\Web.Debug.config
badd +46 IDL.Web.Vc\Web.config
badd +7 ~\.vim\nvim_compatibility.vim
badd +11 ~\AppData\Local\nvim\coc-settings.json
badd +158 IDL.Web.ControlCloud\Content\scripts\services\durationLimits.service.js
badd +6 term://.//28912:pwsh.exe
badd +6 term://.//44024:pwsh.exe
badd +318 IDL.Web.ControlCloud\Content\scripts\directives\datePicker.directive.js
badd +25 ~\.vim\plugins.vim
badd +1 C:\Users\LSYMIN~1\AppData\Local\Temp\coc-nvim-33748.log
badd +3620 IDL.Web.ControlCloud\Content\scripts\controllers\offerCreate.js
badd +1 ~\.vim\functions\number_toggle.vim
badd +37 ~\.vim\general.vim
badd +1177 IDL.Web.ControlCloud\Views\Shared\Partials\OfferEdit.cshtml
badd +378 IDL.Web.ControlCloud\Content\scripts\services\dateTime.service.js
badd +1 IDL.Web.ControlCloud\__vista__
badd +1 term://.//29488:pwsh.exe
badd +546 IDL.Web.ControlCloud\Highlight\ test
badd +1 IDL.Web.ControlCloud\Content\scripts\app.js
badd +1 IDL.Web.ControlCloud\Content\scripts\services\processHTML.service.js
badd +1 ~\.vim\plugin_settings\Defx.vim
badd +26 ~\dotfiles\nvim\.vim\mappings.vim
badd +1 ~\.vim\.netrwhist
badd +42 ~\.vim\ui.vim
badd +7 term://.//1860:pwsh.exe
badd +50 IDL.Web.ControlCloud\Views\Shared\Partials\FeaturingBox.cshtml
badd +65 term://.//28652:pwsh.exe
badd +24 IDL.Web.ControlCloud\Content\angular\less\modules\date-picker.less
badd +1 Content\scripts\templates\date-picker.html
badd +65 term://.//15228:pwsh.exe
badd +23 IDL.Web.ControlCloud\Web.config
badd +520 IDL.Web.ControlCloud\Views\Merchant\Partials\MerchantEdit.cshtml
badd +747 IDL.Web.ControlCloud\Content\scripts\controllers\merchantCreate.js
badd +74 IDL.Web.ControlCloud\Views\Merchant\Partials\OfferTypesFilter.cshtml
badd +158 IDL.Web.ControlCloud\Content\scripts\controllers\merchantOffers.js
badd +214 IDL.Web.ControlCloud\Views\Category\Partials\CategoryEdit.cshtml
badd +348 IDL.Web.ControlCloud\Content\scripts\controllers\categoryEdit.js
badd +722 IDL.Web.ControlCloud\Views\Advert\Partials\AdvertEdit.cshtml
badd +626 IDL.Web.ControlCloud\Content\scripts\controllers\AdvertCreate.js
badd +392 IDL.Web.ControlCloud\Views\ThemedPage\Partials\ThemedPageEdit.cshtml
badd +353 IDL.Web.ControlCloud\Content\scripts\controllers\themedPageCreate.js
badd +1 ~\.vim\plugin_settings\fzf.vim
badd +2 IDL.Web.ControlCloud\Content\scripts\vendor\select2\select2.full.min.js
badd +10 term://.//38504:pwsh.exe
badd +4 term://.//28544:pwsh.exe
badd +40 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_alpha.scss
badd +26 Content\src\style\placeholders\sections\_alpha.scss
badd +9 ~\.vim\plugin_settings\NerdTree.vim
badd +1 ~\AppData\Local\nvim\ginit.vim
badd +1 Content\src\style\placeholders\sections\_alternativeoffers.scss
badd +26 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_alternativeoffers.scss
badd +20 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_base.scss
badd +55 Content\src\style\placeholders\sections\_banner.scss
badd +28 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\banner\_default.scss
badd +174 Content\src\style\placeholders\sections\_carousel.scss
badd +109 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\banner\_hero.scss
badd +111 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_carousel.scss
badd +17 term://.//13044:pwsh.exe
badd +56 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\pages\_merchant.scss
badd +1 Content\src\style\placeholders\pages\_merchant.scss
badd +1 Content\src\style\placeholders\sections\_error.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_error.scss
badd +1 Content\src\style\placeholders\sections\_interstitial.scss
badd +31 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_interstitial.scss
badd +1 Content\src\style\placeholders\sections\_logostrip.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_logostrip.scss
badd +115 Content\src\style\placeholders\sections\_richcontent.scss
badd +8 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_richcontent.scss
badd +1 Content\src\style\placeholders\sections\_search.scss
badd +37 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_search.scss
badd +137 Content\src\style\placeholders\sections\_tablist.scss
badd +113 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_tablist.scss
badd +1 Content\src\style\placeholders\sections\_terms.scss
badd +22 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_terms.scss
badd +73 Content\src\style\placeholders\sections\_textblock.scss
badd +16 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_textblock.scss
badd +410 Content\src\style\placeholders\sections\_themedoffers.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_themedoffers.scss
badd +1 Content\src\style\placeholders\sections\_tilegrid.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_tilegrid.scss
badd +39 Content\src\style\placeholders\sections\_topoffers.scss
badd +54 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_topoffers.scss
badd +1 Content\src\style\placeholders\sections\_verticaltabs.scss
badd +94 IDL.Web.WhiteLabel\Content\src\style\themes\mumsnet\sections\_verticaltabs.scss
badd +7 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\sections\base.scss
badd +41 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\sections\search.scss
badd +13 IDL.Web.WhiteLabel\Web.config
badd +1 C:\Windows\System32\drivers\etc\hosts
badd +28 IDL.Web.WhiteLabel\Views\Shared\Partials\_ThemedRichContent.cshtml
badd +15 IDL.Web.WhiteLabel\Content\src\style\template\sections\verticaltabs.scss
badd +7 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\sections\verticaltabs.scss
badd +25 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\variables.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\sections\tablist.scss
badd +18 IDL.Web.WhiteLabel\Content\src\style\template\sections\tablist.scss
badd +3 IDL.Web.WhiteLabel\Content\src\style\template\tiles\base.scss
badd +7 Content\src\style\themes\foxnews\tiles\base.scss
badd +1 Content\src\style\themes\foxnews\tiles\list.scss
badd +21 IDL.Web.WhiteLabel\Content\src\style\template\tiles\list.scss
badd +21 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\theme.scss
badd +43 IDL.Web.WhiteLabel\Views\Shared\Partials\_HomeCategoryOffers.cshtml
badd +1 IDL.Web.WhiteLabel\Views\ThemedPages\ThemedPageOffers.cshtml
badd +6 IDL.Web.WhiteLabel\Views\Shared\Partials\_CategoryOfferTileList.cshtml
badd +10 IDL.Web.WhiteLabel\Views\Shared\Partials\_OfferTile.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Shared\Themes\FoxNews\_CategoryOfferTileList.cshtml
badd +26 IDL.Web.WhiteLabel\Views\Shared\Partials\_AdvertsHero.cshtml
badd +14 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\elements\text.scss
badd +8 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\elements\base.scss
badd +29 IDL.Web.WhiteLabel\Views\Shared\Themes\Guardian\_CategoryOffersLayout.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Shared\Themes\Guardian\_CategoryTile.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Shared\Themes\Today\_CategoryOfferTileList.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Shared\Themes\HuffPost\_CategoryOfferTileList.cshtml
badd +21 IDL.Web.WhiteLabel\Views\Shared\Themes\HuffPost\_CategoryOffersLayout.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Shared\Themes\Guardian\_OfferTile.cshtml
badd +12 IDL.Web.WhiteLabel\Views\Shared\Themes\HuffPost\_CategoryTile.cshtml
badd +31 IDL.Web.WhiteLabel\Views\Offer\TopOffers.cshtml
badd +17 IDL.Web.WhiteLabel\Views\Shared\Themes\FoxNews\_OfferTile.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Shared\Themes\Today\_OfferTile.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Shared\Themes\Today\_CategoryOffersLayout.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Shared\Themes\Today\_OfferTileList.cshtml
badd +28 IDL.Web.WhiteLabel\Views\Shared\Themes\Today\_OfferCategoryTileList.cshtml
badd +29 IDL.Web.WhiteLabel\Views\Shared\Themes\FoxNews\_OfferCategoryTileList.cshtml
badd +19 IDL.Web.WhiteLabel\Views\Shared\Themes\Today\_TopOfferTile.cshtml
badd +18 IDL.Web.WhiteLabel\Views\Shared\Themes\HuffPost\_OfferTile.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Category\CategoryOffers.cshtml
badd +42 IDL.Web.WhiteLabel\Views\Shared\Themes\HuffPost\_HomeCategoryOffers.cshtml
badd +1 IDL.Web.WhiteLabel\Views\Shared\Themes\FoxNews\_HomeCategoryOffers.cshtml
badd +1 Content\src\style\themes\foxnews\tiles\block.scss
badd +20 IDL.Web.WhiteLabel\Views\Shared\Partials\_TopOfferTile.cshtml
badd +17 IDL.Web.WhiteLabel\Views\Shared\Themes\FoxNews\_TopOfferTile.cshtml
badd +1564 IDL.Web.WhiteLabel\IDL.Web.WhiteLabel.csproj
badd +16 term://.//23996:pwsh.exe
badd +1 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\tiles\block.scss
badd +16 IDL.Web.WhiteLabel\Views\Shared\Themes\HuffPost\_TopOfferTile.cshtml
badd +7 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\tiles\base.scss
badd +4 IDL.Web.WhiteLabel\Views\Shared\Themes\FoxNews\_Index.cshtml
badd +12 IDL.Web.WhiteLabel\Views\Shared\Themes\FoxNews\_HomePopularMerchants.cshtml
badd +5 IDL.Web.WhiteLabel\Views\Shared\Partials\_Index.cshtml
badd +18 IDL.Web.WhiteLabel\Views\Shared\Partials\_HomeTopOffers.cshtml
badd +21 IDL.Web.WhiteLabel\Views\Shared\Themes\FoxNews\_HomeTopOffers.cshtml
badd +1 ~\.vim\plugin_settings\Goyo.vim
badd +1 ~\.vim\plugin_settings\index.vim
badd +34 ~\.vim\plugin_settings\vista.vim
badd +20 IDL.Web.WhiteLabel\Content\src\style\themes\foxnews\tiles\ticket.scss
badd +53 term://.//4680:pwsh.exe
badd +38 term://.//16096:pwsh.exe
badd +26 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_alpha.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_alternativeoffers.scss
badd +55 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_banner.scss
badd +174 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_carousel.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\placeholders\pages\_merchant.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_error.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_interstitial.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_logostrip.scss
badd +115 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_richcontent.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_search.scss
badd +137 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_tablist.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_terms.scss
badd +73 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_textblock.scss
badd +410 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_themedoffers.scss
badd +1 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_tilegrid.scss
badd +39 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_topoffers.scss
badd +127 IDL.Web.WhiteLabel\Content\src\style\placeholders\sections\_verticaltabs.scss
badd +83 IDL.Web.ControlCloud\BootStrap\Configuration\ConfigureBundles.cs
badd +1 IDL.Web.ControlCloud\Content\scripts\services\confirmationModal.service.js
badd +15 IDL.Web.ControlCloud\Content\scripts\services\formValidationMessaging.service.js
badd +42 IDL.Web.ControlCloud\Content\scripts\services\formValidation.service.js
badd +15 IDL.Web.ControlCloud\Views\Merchant\Edit.cshtml
badd +13 IDL.Web.ControlCloud\Views\Category\Edit.cshtml
badd +18 IDL.Web.ControlCloud\Views\Merchant\Create.cshtml
badd +15 IDL.Web.ControlCloud\Views\Advert\Edit.cshtml
badd +29 IDL.Web.ControlCloud\Views\Merchant\MerchantOffers.cshtml
badd +16 IDL.Web.ControlCloud\Views\Shared\Partials\OfferBaseView.cshtml
badd +20 IDL.Web.ControlCloud\Views\Advert\Create.cshtml
badd +480 IDL.Web.ControlCloud\Content\angular\less\modules\forms.less
badd +2184 IDL.Web.ControlCloud\IDL.Web.ControlCloud.csproj
badd +1 IDL.Web.ControlCloud\_coc-rename
badd +9 ~\.vim\theme.vim
badd +1 ~\.vim\plugin_settings\fugitive.vim
badd +15 ~\dotfiles\nvim\.vim\functions\which_env.vim
badd +1 .git\index
badd +17 ~/AppData/Local/nvim/.vimrc
badd +1 ~/.vim/plugin_settings/lightline.vim
badd +1 ~/.vim/plugin_settings/omnisharp.vim
badd +2 ~/.vim/plugin_settings/seoul256.vim
badd +1 C:/smsbootsect.bak
badd +5 ~/dotfiles/nvim/.vim/highlights.vim
argglobal
silent! argdel *
$argadd IDL.Web.ControlCloud\_coc-rename
edit IDL.Web.ControlCloud\Content\scripts\directives\datePicker.directive.js
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
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
let s:l = 313 - ((13 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
313
normal! 046|
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
