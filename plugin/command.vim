if exists("g:loaded_yeolar_command") || &cp || v:version < 700
    finish
endif
let g:loaded_yeolar_command = 1

fun! s:comment(arg)
  if (a:arg == "")
    let s:cc = "Copyright ".strftime("%Y")." Yeolar"
    if (&ft == "c" || &ft == "cpp")
      exec "normal O"."/*\<enter>".s:cc."\<enter>/\<enter>\<down>"
    elseif (&ft == "sh" || &ft == "python")
      exec "normal O"."#!/usr/bin/env python\<enter># -*- coding: utf-8 -*-\<enter>#\<enter># ".s:cc."\<enter>#\<enter>"
    else
      exec "normal O".s:cc
    endif
  elseif (a:arg == "a")
    if (&ft == "c" || &ft == "cpp")
      exec "normal A"."/* Added by Yeolar */"
    elseif (&ft == "sh" || &ft == "python")
      exec "normal A"."# Added by Yeolar"
    else
      exec "normal A"."Added by Yeolar"
    endif
  endif
endfun

fun! s:cc_comment(arg)
  if (a:arg == "")
    let s:cc = "Copyright ".strftime("%Y")." Yeolar"
    exec "normal O"."//\<enter> ".s:cc."\<enter>\<enter>\<bs>\<bs>\<bs>\<down>"
  elseif (a:arg == "a")
    exec "normal A"."// Added by Yeolar"
  endif
endfun

fun! s:license_apache(arg)
  let s:lic = "Licensed under the Apache License, Version 2.0 (the \"License\");\<enter>you may not use this file except in compliance with the License.\<enter>You may obtain a copy of the License at\<enter>\<enter>  http://www.apache.org/licenses/LICENSE-2.0\<enter>\<enter>\<bs>\<bs> Unless required by applicable law or agreed to in writing, software\<enter>distributed under the License is distributed on an \"AS IS\" BASIS,\<enter>WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\<enter>See the License for the specific language governing permissions and\<enter>limitations under the License."
  exec "normal O"."\<enter>".s:lic
endfun

fun! s:c_head_file_def(arg)
  if (a:arg != "")
    let s:hf = toupper(substitute(a:arg, "[\.]", "_", "g"))."_".toupper(expand("%:t:r"))."_H_"
  else
    let s:hf = toupper(expand("%:t:r"))."_H_"
  endif
  exec "normal O"."#ifndef ".s:hf."\<enter>#define ".s:hf."\<enter>\<enter>\<enter>\<enter>#endif /* ".s:hf." */\<up>\<up>"
endfun

fun! s:c_namespace(arg)
  for key in split(a:arg, ':', 1)
    if (key != "")
      let s:ns = " ".key
    else
      let s:ns = ""
    endif
    exec "normal i"."namespace".s:ns." {\<enter>\<enter>} // namespace".s:ns."\<up>"
  endfor
endfun

command! -nargs=? C       :call s:comment("<args>")
command! -nargs=? CC      :call s:cc_comment("<args>")
command! -nargs=? Lapache :call s:license_apache("<args>")
command! -nargs=? CH      :call s:c_head_file_def("<args>")
command! -nargs=? CNS     :call s:c_namespace("<args>")

