let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd C:\git\vouchercloud-idl\IDL.Web.WhiteLabel
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 C:\git\vouchercloud-idl\IDL.Web.Vc\Web.Debug.config
badd +46 C:\git\vouchercloud-idl\IDL.Web.Vc\Web.config
badd +1 ~\AppData\Local\nvim\init.vim
badd +6 ~\.vim\nvim_compatibility.vim
badd +10 ~\AppData\Local\nvim\coc-settings.json
badd +217 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\services\durationLimits.service.js
badd +6 term://.//28912:pwsh.exe
badd +6 term://.//44024:pwsh.exe
badd +283 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\directives\datePicker.directive.js
badd +25 ~\.vim\plugins.vim
badd +1 C:\Users\LSYMIN~1\AppData\Local\Temp\coc-nvim-33748.log
badd +2935 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\controllers\offerCreate.js
badd +1 ~\.vim\functions\number_toggle.vim
badd +51 ~\.vim\general.vim
badd +465 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Views\Shared\Partials\OfferEdit.cshtml
badd +233 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\services\dateTime.service.js
badd +1 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\__vista__
badd +1 term://.//29488:pwsh.exe
badd +546 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Highlight\ test
badd +1 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\app.js
badd +1 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\services\processHTML.service.js
badd +25 ~\.vim\plugin_settings\Defx.vim
badd +26 ~\dotfiles\nvim\.vim\mappings.vim
badd +1 ~\.vim\.netrwhist
badd +42 ~\.vim\ui.vim
badd +7 term://.//1860:pwsh.exe
badd +38 ~\.vim\plugin_settings\ale.vim
badd +81 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Views\Shared\Partials\FeaturingBox.cshtml
badd +65 term://.//28652:pwsh.exe
badd +24 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\angular\less\modules\date-picker.less
badd +1 Content\scripts\templates\date-picker.html
badd +65 term://.//15228:pwsh.exe
badd +85 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Web.config
badd +385 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Views\Merchant\Partials\MerchantEdit.cshtml
badd +822 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\controllers\merchantCreate.js
badd +57 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Views\Merchant\Partials\OfferTypesFilter.cshtml
badd +132 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\controllers\merchantOffers.js
badd +249 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Views\Category\Partials\CategoryEdit.cshtml
badd +371 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\controllers\categoryEdit.js
badd +311 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Views\Advert\Partials\AdvertEdit.cshtml
badd +1 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\controllers\AdvertCreate.js
badd +207 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Views\ThemedPage\Partials\ThemedPageEdit.cshtml
badd +343 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\controllers\themedPageCreate.js
badd +1 ~\.vim\plugin_settings\fzf.vim
badd +2 C:\git\vouchercloud-idl\IDL.Web.ControlCloud\Content\scripts\vendor\select2\select2.full.min.js
badd +10 term://.//38504:pwsh.exe
badd +4 term://.//28544:pwsh.exe
badd +40 Content\src\style\themes\mumsnet\sections\_alpha.scss
badd +26 Content\src\style\placeholders\sections\_alpha.scss
badd +9 ~\.vim\plugin_settings\NerdTree.vim
badd +1 ~\AppData\Local\nvim\ginit.vim
badd +1 Content\src\style\placeholders\sections\_alternativeoffers.scss
badd +26 Content\src\style\themes\mumsnet\sections\_alternativeoffers.scss
badd +20 Content\src\style\themes\mumsnet\sections\_base.scss
badd +55 Content\src\style\placeholders\sections\_banner.scss
badd +28 Content\src\style\themes\mumsnet\sections\banner\_default.scss
badd +174 Content\src\style\placeholders\sections\_carousel.scss
badd +109 Content\src\style\themes\mumsnet\sections\banner\_hero.scss
badd +111 Content\src\style\themes\mumsnet\sections\_carousel.scss
badd +17 term://.//13044:pwsh.exe
badd +56 Content\src\style\themes\mumsnet\pages\_merchant.scss
badd +1 Content\src\style\placeholders\pages\_merchant.scss
badd +1 Content\src\style\placeholders\sections\_error.scss
badd +1 Content\src\style\themes\mumsnet\sections\_error.scss
badd +1 Content\src\style\placeholders\sections\_interstitial.scss
badd +31 Content\src\style\themes\mumsnet\sections\_interstitial.scss
badd +1 Content\src\style\placeholders\sections\_logostrip.scss
badd +1 Content\src\style\themes\mumsnet\sections\_logostrip.scss
badd +115 Content\src\style\placeholders\sections\_richcontent.scss
badd +8 Content\src\style\themes\mumsnet\sections\_richcontent.scss
badd +1 Content\src\style\placeholders\sections\_search.scss
badd +37 Content\src\style\themes\mumsnet\sections\_search.scss
badd +137 Content\src\style\placeholders\sections\_tablist.scss
badd +113 Content\src\style\themes\mumsnet\sections\_tablist.scss
badd +1 Content\src\style\placeholders\sections\_terms.scss
badd +22 Content\src\style\themes\mumsnet\sections\_terms.scss
badd +73 Content\src\style\placeholders\sections\_textblock.scss
badd +16 Content\src\style\themes\mumsnet\sections\_textblock.scss
badd +410 Content\src\style\placeholders\sections\_themedoffers.scss
badd +1 Content\src\style\themes\mumsnet\sections\_themedoffers.scss
badd +1 Content\src\style\placeholders\sections\_tilegrid.scss
badd +1 Content\src\style\themes\mumsnet\sections\_tilegrid.scss
badd +39 Content\src\style\placeholders\sections\_topoffers.scss
badd +54 Content\src\style\themes\mumsnet\sections\_topoffers.scss
badd +1 Content\src\style\placeholders\sections\_verticaltabs.scss
badd +1 Content\src\style\themes\mumsnet\sections\_verticaltabs.scss
badd +12 Content\src\style\themes\foxnews\sections\base.scss
badd +41 Content\src\style\themes\foxnews\sections\search.scss
badd +13 Web.config
badd +1 C:\Windows\System32\drivers\etc\hosts
badd +28 Views\Shared\Partials\_ThemedRichContent.cshtml
badd +15 Content\src\style\template\sections\verticaltabs.scss
badd +7 Content\src\style\themes\foxnews\sections\verticaltabs.scss
badd +12 Content\src\style\themes\foxnews\variables.scss
badd +1 Content\src\style\themes\foxnews\sections\tablist.scss
badd +18 Content\src\style\template\sections\tablist.scss
badd +3 Content\src\style\template\tiles\base.scss
badd +10 Content\src\style\themes\foxnews\tiles\base.scss
badd +1 Content\src\style\themes\foxnews\tiles\list.scss
badd +21 Content\src\style\template\tiles\list.scss
badd +30 Content\src\style\themes\foxnews\theme.scss
badd +43 Views\Shared\Partials\_HomeCategoryOffers.cshtml
badd +1 Views\ThemedPages\ThemedPageOffers.cshtml
badd +6 Views\Shared\Partials\_CategoryOfferTileList.cshtml
badd +10 Views\Shared\Partials\_OfferTile.cshtml
badd +1 Views\Shared\Themes\FoxNews\_CategoryOfferTileList.cshtml
badd +26 Views\Shared\Partials\_AdvertsHero.cshtml
badd +14 Content\src\style\themes\foxnews\elements\text.scss
badd +8 Content\src\style\themes\foxnews\elements\base.scss
badd +29 Views\Shared\Themes\Guardian\_CategoryOffersLayout.cshtml
badd +1 Views\Shared\Themes\Guardian\_CategoryTile.cshtml
badd +1 Views\Shared\Themes\Today\_CategoryOfferTileList.cshtml
badd +1 Views\Shared\Themes\HuffPost\_CategoryOfferTileList.cshtml
badd +21 Views\Shared\Themes\HuffPost\_CategoryOffersLayout.cshtml
badd +1 Views\Shared\Themes\Guardian\_OfferTile.cshtml
badd +12 Views\Shared\Themes\HuffPost\_CategoryTile.cshtml
badd +31 Views\Offer\TopOffers.cshtml
badd +17 Views\Shared\Themes\FoxNews\_OfferTile.cshtml
badd +1 Views\Shared\Themes\Today\_OfferTile.cshtml
badd +1 Views\Shared\Themes\Today\_CategoryOffersLayout.cshtml
badd +1 Views\Shared\Themes\Today\_OfferTileList.cshtml
badd +28 Views\Shared\Themes\Today\_OfferCategoryTileList.cshtml
badd +29 Views\Shared\Themes\FoxNews\_OfferCategoryTileList.cshtml
badd +7 Views\Shared\Themes\Today\_TopOfferTile.cshtml
badd +18 Views\Shared\Themes\HuffPost\_OfferTile.cshtml
badd +1 Views\Category\CategoryOffers.cshtml
badd +42 Views\Shared\Themes\HuffPost\_HomeCategoryOffers.cshtml
badd +1 Views\Shared\Themes\FoxNews\_HomeCategoryOffers.cshtml
badd +1 Content\src\style\themes\foxnews\tiles\block.scss
badd +20 Views\Shared\Partials\_TopOfferTile.cshtml
badd +14 Views\Shared\Themes\FoxNews\_TopOfferTile.cshtml
badd +1564 IDL.Web.WhiteLabel.csproj
badd +16 term://.//23996:pwsh.exe
badd +16 Views\Shared\Themes\HuffPost\_TopOfferTile.cshtml
badd +1 Views\Shared\Themes\FoxNews\_Index.cshtml
badd +12 Views\Shared\Themes\FoxNews\_HomePopularMerchants.cshtml
badd +5 Views\Shared\Partials\_Index.cshtml
badd +20 Views\Shared\Partials\_HomeTopOffers.cshtml
badd +1 Views\Shared\Themes\FoxNews\_HomeTopOffers.cshtml
badd +1 ~\.vim\plugin_settings\Goyo.vim
badd +23 ~\.vim\plugin_settings\index.vim
badd +1 ~\.vim\plugin_settings\vista.vim
badd +5 Content\src\style\themes\foxnews\tiles\ticket.scss
badd +1 Content\src\style\themes\foxnews\sections\topoffers.scss
badd +1 Content\src\style\themes\foxnews\sections\popular.scss
badd +4 ~/.vim/plugin_settings/OmniSharp.vim
badd +1 ~/.vim/plugin_settings/airline.vim
badd +19 Constants.cs
argglobal
silent! argdel *
edit Content\src\style\themes\foxnews\sections\tablist.scss
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
let s:l = 1 - ((0 * winheight(0) + 33) / 66)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd C:\git\vouchercloud-idl\IDL.Web.WhiteLabel
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
