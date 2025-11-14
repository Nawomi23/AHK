#SingleInstance, Force
#UseHook
#NoEnv
SetWorkingDir %A_ScriptDir%
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
#Persistent

SplashTextoff
ListLines Off
Process, Priority, , A
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
reloadStatus = 0
DayANS = 0
WeekANS = 0
FormatTime, CurrentDate,, ddMM

Usefull = Полезное
Cheatsheet = Меню памятки

; --- Функция быстрой загрузки файлов ---
Download(url, file) {
    try {
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", url, false)
        whr.Send()
        if (whr.Status = 200) {
            stream := ComObjCreate("ADODB.Stream")
            stream.Type := 1
            stream.Open()
            stream.Write(whr.ResponseBody)
            stream.SaveToFile(file, 2) ; overwrite
            stream.Close()
        }
    }
}

IfNotExist, %A_ScriptDir%\ahk
{
    FileCreateDir, %A_ScriptDir%\ahk
}

; ====== ТЕКУЩАЯ ВЕРСИЯ СКРИПТА ======
CurrentVersion := "1.0"

; ====== ФАЙЛЫ НА GITHUB ======
VersionURL := "https://raw.githubusercontent.com/Nawomi23/AHK/refs/heads/main/version.txt"
ScriptURL := "https://raw.githubusercontent.com/Nawomi23/AHK/refs/heads/main/AHK%20by%20Norton.ahk"

; ====== ПОЛУЧАЕМ ВЕРСИЮ ИЗ GITHUB ======
UrlDownloadToFile, %VersionURL%, %A_Temp%\version.txt

if FileExist(A_Temp "\version.txt")
{
    FileRead, NewVersion, %A_Temp%\version.txt
    NewVersion := Trim(NewVersion)

    ; ====== СРАВНИВАЕМ ВЕРСИИ ======
    if (NewVersion != "" && NewVersion > CurrentVersion)
    {
        MsgBox, 4, Обновление доступно, Доступна новая версия (%NewVersion%).`nОбновить сейчас?
        IfMsgBox Yes
        {
            ; Скачиваем новый скрипт
            UrlDownloadToFile, %ScriptURL%, %A_ScriptFullPath%.new

            if FileExist(A_ScriptFullPath ".new")
            {
                ; Заменяем старый
                FileMove, %A_ScriptFullPath%.new, %A_ScriptFullPath%, 1

                MsgBox, Обновление завершено! Скрипт будет перезапущен.
                Run, %A_ScriptFullPath%
                ExitApp
            }
            else
            {
                MsgBox, Не удалось скачать обновление!
            }
        }
    }
}

; --- Скачивание иконок ---
Download("https://i.imgur.com/gc0OxVl.png", A_ScriptDir "\ahk\gc0OxVl.png") ;гос
Download("https://i.imgur.com/hEFlHSA.png", A_ScriptDir "\ahk\hEFlHSA.png") ;иконка
Download("https://i.imgur.com/f1P9nBu.png", A_ScriptDir "\ahk\f1P9nBu.png") ;одежда
Download("https://i.imgur.com/KxTO850.png", A_ScriptDir "\ahk\KxTO850.png") ;сохранить
Download("https://i.imgur.com/GqYwynV.png", A_ScriptDir "\ahk\GqYwynV.png") ;инфо
Download("https://i.imgur.com/Rj8QccZ.png", A_ScriptDir "\ahk\Rj8QccZ.png") ;гайд
Download("https://i.imgur.com/OlsrmKS.png", A_ScriptDir "\ahk\OlsrmKS.png") ;бинд
Download("https://i.imgur.com/aZTDoTI.png", A_ScriptDir "\ahk\aZTDoTI.png") ;авторизация
Download("https://i.imgur.com/wHj4jWd.png", A_ScriptDir "\ahk\wHj4jWd.png") ;дс
Download("https://i.imgur.com/TZgQPo4.png", A_ScriptDir "\ahk\TZgQPo4.png") ;репорты
Download("https://i.imgur.com/IbaxasN.png", A_ScriptDir "\ahk\IbaxasN.png") ;пол
Download("https://i.imgur.com/3SgnKI3.png", A_ScriptDir "\ahk\3SgnKI3.png") ;лид
Download("https://i.imgur.com/EbTqEfl.png", A_ScriptDir "\ahk\EbTqEfl.png") ;время
Download("https://i.imgur.com/Bv4ze5l.png", A_ScriptDir "\ahk\Bv4ze5l.png") ;фам
Download("https://i.imgur.com/3W3OIQ0.png", A_ScriptDir "\ahk\3W3OIQ0.png") ;mcl
Download("https://i.imgur.com/LvzZG7L.png", A_ScriptDir "\ahk\LvzZG7L.png") ;мероприятия
Download("https://i.imgur.com/WR6dImS.png", A_ScriptDir "\ahk\WR6dImS.png") ;дименшен

Menu,Tray,Icon,%A_ScriptDir%\ahk\hEFlHSA.png

FileSetAttrib, +H, %A_ScriptDir%\ahk

Menu, Tray, add, Показать, Show,
Menu, Tray, Default, Показать,
Menu, Tray, add, Перезагрузить, Reload,
Menu, Tray, add, Скрыть, Hide,
Menu, Tray, add, Закрыть, Close,
Menu, Tray, NoStandard

IniRead, Week, %A_ScriptDir%\ahk\Settings.ini, ANS, Week
IniRead, CurrentDateT, %A_ScriptDir%\ahk\Settings.ini, ANS, CurrentDateT
if CurrentDateT=%CurrentDate%
{
IniRead, CurrentDateT, %A_ScriptDir%\ahk\Settings.ini, ANS, CurrentDateT
IniRead, DayANS, %A_ScriptDir%\ahk\Settings.ini, ANS, DayANS
}
else
{
    IniWrite, %CurrentDate%, %A_ScriptDir%\ahk\Settings.ini, ANS, CurrentDateT
    IniWrite, %DayANS%, %A_ScriptDir%\ahk\Settings.ini, ANS, DayANS
    IniRead, DayANS, %A_ScriptDir%\ahk\Settings.ini, ANS, DayANS
    IniRead, CurrentDateT, %A_ScriptDir%\ahk\Settings.ini, ANS, CurrentDateT
}
if Week=%A_YWeek%
{
IniRead, Week, %A_ScriptDir%\ahk\Settings.ini, ANS, Week
IniRead, WeekANS, %A_ScriptDir%\ahk\Settings.ini, ANS, WeekANS
}
else
{
    IniWrite, %A_YWeek%, %A_ScriptDir%\ahk\Settings.ini, ANS, Week
    IniWrite, %WeekANS%, %A_ScriptDir%\ahk\Settings.ini, ANS, WeekANS
    IniRead, WeekANS, %A_ScriptDir%\ahk\Settings.ini, ANS, WeekANS
    IniRead, Week, %A_ScriptDir%\ahk\Settings.ini, ANS, Week
}
IniRead, Radio1, %A_ScriptDir%\ahk\Settings.ini, gender, gender1
IniRead, Radio2, %A_ScriptDir%\ahk\Settings.ini, gender, gender2
IniRead, Radio8, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /settimelocal
IniRead, Radio9, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /gm
IniRead, Radio10, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /dl
IniRead, Radio11, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /esp3
IniRead, Radio12, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /templeader
IniRead, Radio13, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /chide
IniRead, Radio14, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /setdim

IniRead, key1, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY1
IniRead, key2, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY2
IniRead, key3, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY3
IniRead, key4, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY4
IniRead, key5, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY5
IniRead, key6, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY6
IniRead, key7, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY7
IniRead, key8, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY8
IniRead, key9, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY9

IniRead, dis, %A_ScriptDir%\ahk\Settings.ini, Discord, dis
IniRead, gadis, %A_ScriptDir%\ahk\Settings.ini, Discord, gadis
IniRead, zgadis, %A_ScriptDir%\ahk\Settings.ini, Discord, zgadis

if dis=ERROR
{
IniWrite, dbleck23, %A_ScriptDir%\ahk\Settings.ini, Discord, dis
IniWrite, tonnyque, %A_ScriptDir%\ahk\Settings.ini, Discord, gadis
IniWrite, morallyexhausted, %A_ScriptDir%\ahk\Settings.ini, Discord, zgadis
}

IniRead, X, %A_ScriptDir%\ahk\Settings.ini, Coords, X
IniRead, Y, %A_ScriptDir%\ahk\Settings.ini, Coords, Y
IniRead, Fraction, %A_ScriptDir%\ahk\Settings.ini, Fraction, Fraction
IniRead, Dimension, %A_ScriptDir%\ahk\Settings.ini, Dimension, Dimension
IniRead, fam, %A_ScriptDir%\ahk\Settings.ini, fam, fam
IniRead, Settimelocal, %A_ScriptDir%\ahk\Settings.ini, Settimelocal, Settimelocal


if X=ERROR
{
IniWrite, 0, %A_ScriptDir%\ahk\Settings.ini, Coords, X
IniWrite, 0, %A_ScriptDir%\ahk\Settings.ini, Coords, Y
IniWrite, 222, %A_ScriptDir%\ahk\Settings.ini, Dimension, Dimension
IniWrite, 6, %A_ScriptDir%\ahk\Settings.ini, fam, fam
IniWrite, 7, %A_ScriptDir%\ahk\Settings.ini, Fraction, Fraction
IniWrite, 18 00 00, %A_ScriptDir%\ahk\Settings.ini, Settimelocal, Settimelocal

reload
}

;гуи счетчика
WinSet_Click_Through(I, T="254") {
IfWinExist, % "ahk_id " I
{
If (T == "Off")
{
WinSet, AlwaysOnTop, Off, % "ahk_id " I
WinSet, Transparent, Off, % "ahk_id " I
WinSet, ExStyle, -0x20, % "ahk_id " I
}
Else
{
WinSet, AlwaysOnTop, On, % "ahk_id " I
If(T < 0 || T > 254 || T == "On")
T := 254
WinSet, Transparent, % T, % "ahk_id " I
WinSet, ExStyle, +0x20, % "ahk_id " I
}
}
Else
Return 0
}
Gui, +LastFound +ToolWindow
ID := WinExist()
Gui, Show, NoActivate, Hide x0 y0 w0 h0, Overlay
WinSet_Click_Through(ID, "On")
GuiControl,, Un-Clickable
CustomColor := "#00FF00"
Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, Color, cRed
Gui, Font,, Proxima Nova
Gui, Font, s10
Gui, Font, q1
Gui, Font, w400
Gui, Add, Text, x9 vMyText cWhite, XXX, YYYY
Gui, Add, Text, x107 y7 vMyTotalR cWhite, XXXXXX, YYYYYY
Gui, Color, 292727
WinSet, TransColor, AAAAAA 170
GoSub, UpdateCounter1
Gui, Show, x%X% y%Y% w212 h30, Overlay

Hotkey, %KEY1%, Off, UseErrorLevel
Hotkey, %KEY1%, vhod, On, UseErrorLevel
Hotkey, %KEY2%, Off, UseErrorLevel
Hotkey, %KEY2%, repm, On, UseErrorLevel
Hotkey, %KEY3%, Off, UseErrorLevel
Hotkey, %KEY3%, rep, On, UseErrorLevel
Hotkey, %KEY4%, Off, UseErrorLevel
Hotkey, %KEY4%, strel, On, UseErrorLevel
Hotkey, %KEY5%, Off, UseErrorLevel
Hotkey, %KEY5%, ar, On, UseErrorLevel
Hotkey, %KEY6%, Off, UseErrorLevel
Hotkey, %KEY6%, derb, On, UseErrorLevel
Hotkey, %KEY7%, Off, UseErrorLevel
Hotkey, %KEY7%, vb, On, UseErrorLevel
Hotkey, %KEY8%, Off, UseErrorLevel
Hotkey, %KEY8%, vd, On, UseErrorLevel
Hotkey, %KEY9%, Off, UseErrorLevel
Hotkey, %KEY9%, vb, On, UseErrorLevel
Hotkey, %KEY10%, Off, UseErrorLevel
Hotkey, %KEY10%, startfamtimer, On, UseErrorLevel
Hotkey, %KEY11%, Off, UseErrorLevel
Hotkey, %KEY11%, listfamtimers, On, UseErrorLevel
Hotkey, %KEY12%, Off, UseErrorLevel
Hotkey, %KEY12%, stopfamtimer, On, UseErrorLevel
Hotkey, %KEY13%, Off, UseErrorLevel
Hotkey, %KEY13%, continuefamtimer, On, UseErrorLevel
Hotkey, %KEY14%, Off, UseErrorLevel
Hotkey, %KEY14%, deletefamtimer, On, UseErrorLevel
Hotkey, %KEY15%, Off, UseErrorLevel
Hotkey, %KEY15%, feventon, On, UseErrorLevel
Hotkey, %KEY16%, Off, UseErrorLevel
Hotkey, %KEY16%, feventoff, On, UseErrorLevel

;Общая инфа
Gui, Main: Font, s8.5 cwhite, Verdana
Gui, Main: +MinimizeBox +SysMenu
Gui, Main: Color, 21262d

; Создаём вкладки
Gui, Main: Add, Tab, x0 y0 w390 h406, Хоткеи|Настройки|Ивенты|Выдача

; Показываем GUI
Gui, Main: Show, w390 h406, Miami AutoHotKey

;Верхние боксы
;Gui, Main: Add, GroupBox, x8 y18 w194 h27 cA52A2A, ; бинда
Gui, Main: Add, Picture, x8 y24 w184 h27, %A_ScriptDir%\ahk\OlsrmKS.png

;Gui, Main: Add, GroupBox, x209 y18 w173 h27 cA52A2A, ; команды
Gui, Main: Add, Picture, x198 y24 w184 h27, %A_ScriptDir%\ahk\aZTDoTI.png

;Верхний текст
;Gui, Main: Add, Text, x85 y28 BackgroundTrans, Бинды
;Gui, Main: Add, Text, x233 y28 BackgroundTrans, Команды при входе

;Нижний блок кнопок
Gui, Main: Add, GroupBox, x10 y350 w370 h9 cA52A2A, ;бокс
Gui, Main: Add, Picture, x29 y363 w80 h38 gInfo , %A_ScriptDir%\ahk\GqYwynV.png
Gui, Main: Add, Picture, x113 y363 w80 h38 gOpenSite , %A_ScriptDir%\ahk\f1P9nBu.png
Gui, Main: Add, Picture, x197 y363 w80 h38 gOpenAnotherSite , %A_ScriptDir%\ahk\Rj8QccZ.png
Gui, Main: Add, Picture, x281 y363 w80 h38 gSaveData, %A_ScriptDir%\ahk\KxTO850.png

;Спец.команды
Gui, Main: Add, Hotkey, x11 y60 w57 h21 vHot1, %KEY1% ; Команды при входе
Gui, Main: Add, Hotkey, x11 y86 w70 h21 vHot2, %KEY2% ; -реп
Gui, Main: Add, Hotkey, x11 y113 w70 h21 vHot3, %KEY3% ; +1 репорт

Gui, Main: Add, Text, x72 y63 w127 h14 +0x200, Команды при входе
Gui, Main: Add, Text, x85 y89 w120 h14 +0x200, Убрать -1 реп
Gui, Main: Add, Text, x85 y116 BackgroundTrans, Добавить +1 реп

;Команды при входе
Gui, Main: Add, CheckBox, x217 y60 BackgroundTrans vRadio8 Checked%Radio8%, /settimelocal %Settimelocal%
Gui, Main: Add, CheckBox, x217 y81 w120 h23 vRadio9 Checked%Radio9%, /gm
Gui, Main: Add, CheckBox, x217 y107 w120 h23 vRadio10 Checked%Radio10%, /dl
Gui, Main: Add, CheckBox, x217 y133 w120 h23 vRadio11 Checked%Radio11%, /esp3
Gui, Main: Add, CheckBox, x217 y159 w120 h23 vRadio12 Checked%Radio12%, /templeader %Fraction%
Gui, Main: Add, CheckBox, x217 y185 w120 h23 vRadio13 Checked%Radio13%, /chide
Gui, Main: Add, CheckBox, x217 y211 w120 h23 vRadio14 Checked%Radio14%, /setdim id %Dimension%

;скрыто 

;настройки  
Gui, Main: Tab, 2
;Боксы 
;Gui, Main: Add, GroupBox, x8 y68 w194 h27 cA52A2A, ;лида
;Gui, Main: Add, GroupBox, x8 y19 w194 h27 cA52A2A, ;пол
;Gui, Main: Add, GroupBox, x209 y19 w173 h27 cA52A2A, ;дискорд
;Gui, Main: Add, GroupBox, x8 y124 w194 h27 cA52A2A, ;Счетчик репортов
;Gui, Main: Add, GroupBox, x209 y124 w173 h27 cA52A2A, ;Время 

;Нижний блок кнопок
Gui, Main: Add, GroupBox, x10 y350 w370 h9 cA52A2A, ;бокс
Gui, Main: Add, Picture, x29 y363 w80 h38 gInfo , %A_ScriptDir%\ahk\GqYwynV.png
Gui, Main: Add, Picture, x113 y363 w80 h38 gOpenSite , %A_ScriptDir%\ahk\f1P9nBu.png
Gui, Main: Add, Picture, x197 y363 w80 h38 gOpenAnotherSite , %A_ScriptDir%\ahk\Rj8QccZ.png
Gui, Main: Add, Picture, x281 y363 w80 h38 gSaveData, %A_ScriptDir%\ahk\KxTO850.png

;Текста
;Gui, Main: Add, Text, x34 y77 BackgroundTrans, Временное лидерство
Gui, Main: Add, Picture, x8 y75 w186 h27, %A_ScriptDir%\ahk\3SgnKI3.png ; лида
;Gui, Main: Add, Text, x67 y28 BackgroundTrans, Выбор пола
Gui, Main: Add, Picture, x8 y24 w184 h27, %A_ScriptDir%\ahk\IbaxasN.png ; пол
;Gui, Main: Add, Text, x263 y28 BackgroundTrans, Дискорды
Gui, Main: Add, Picture, x198 y24 w184 h27, %A_ScriptDir%\ahk\wHj4jWd.png ; дс
;Gui, Main: Add, Text, x44 y134 w122 h14 +0x200 , Счетчик репортов
Gui, Main: Add, Picture, x8 y128 w184 h27, %A_ScriptDir%\ahk\TZgQPo4.png ; репы
;Gui, Main: Add, Text, x228 y134 w138 h14 +0x200 , Установочное время
Gui, Main: Add, Picture, x198 y128 w184 h27, %A_ScriptDir%\ahk\EbTqEfl.png ; время

;пол
Gui, Main: Add, Radio, x12 y55 w78 h23 Group vRadio1 Checked%Radio1%, Мужской
Gui, Main: Add, Radio, x112 y55 w80 h23 vRadio2 Checked%Radio2%, Женский

Gui, Main: Add, Text, x50 y111 w120 h14 +0x200, Номер фракции
Gui, Main: Add, Edit, x12 y109 w33 h21 vFraction +number cblack, %Fraction%

Gui, Main: Add, Text, x65 y162 BackgroundTrans, Координата X
Gui, Main: Add, Text, x65 y190 BackgroundTrans, Координата Y

Gui, Main: Add, Edit, x12 y158 w48 h21 vX + cblack, %X%
Gui, Main: Add, Edit, x12 y186 w48 h21 vY + cblack, %Y%

Gui, Main: Add, Text, x279 y162 w100 h14 +0x200, Время settime
Gui, Main: Add, Edit, x208 y158 w65 h21 vSettimelocal + cblack, %Settimelocal%

;Дискорд
Gui, Main: Add, Text, x279 y59 BackgroundTrans, Дискорд 
Gui, Main: Add, Edit, x208 y55 w65 h21 vdis cblack, %dis%

Gui, Main: Add, Text, x279 y87 BackgroundTrans, Дискорд ГА
Gui, Main: Add, Edit, x208 y83 w65 h21 vgadis cblack, %gadis%

Gui, Main: Add, Text, x279 y115 BackgroundTrans, Дискорд зГА 
Gui, Main: Add, Edit, x208 y111 w65 h21 vzgadis cblack, %zgadis%

;Пикчи
Gui, Main: Add, Picture, x8 y206 w380 h145, %A_ScriptDir%\ahk\gc0OxVl.png

;events
Gui, Main: Tab, 3

;верхнии боксы
;Gui, Main: Add, GroupBox, x8 y19 w194 h27 cA52A2A, ;Мероприятия
;Gui, Main: Add, GroupBox, x209 y19 w173 h27 cA52A2A, ;Дименшен

;Тексты
Gui, Main: Add, Picture, x8 y24 w184 h27, %A_ScriptDir%\ahk\LvzZG7L.png ; Мероприятия
Gui, Main: Add, Picture, x198 y24 w184 h27, %A_ScriptDir%\ahk\WR6dImS.png ; дим

Gui, Main: Add, Text, x262 y59 BackgroundTrans, Дименшен
Gui, Main: Add, Edit, x208 y55 w48 h21 vDimension +number cblack, %Dimension%

;fam id
Gui, Main: Add, Picture, x198 y76 w184 h27, %A_ScriptDir%\ahk\Bv4ze5l.png
Gui, Main: Add, Text, x262 y123 BackgroundTrans, fam id
Gui, Main: Add, Edit, x208 y120 w48 h21 vfam +number cblack, %fam%

;MCL commands
Gui, Main: Add, Picture, x8 y129 w184 h27, %A_ScriptDir%\ahk\3W3OIQ0.png 

Gui, Main: Add, Hotkey, x12 y162 w57 h21 vHot10, %KEY10% ; /startfamtimer
Gui, Main: Add, Hotkey, x12 y191 w57 h21 vHot11, %KEY11% ; /listfamtimers
Gui, Main: Add, Hotkey, x12 y220 w57 h21 vHot12, %KEY12% ; /stopfamtimer
Gui, Main: Add, Hotkey, x12 y249 w57 h21 vHot14, %KEY14% ; /deletefamtimer
Gui, Main: Add, Hotkey, x12 y278 w57 h21 vHot15, %KEY15% ; /feventon
Gui, Main: Add, Hotkey, x12 y307 w57 h21 vHot16, %KEY16% ; /feventoff
Gui, Main: Add, Hotkey, x165 y162 w27 h21 vHot17, %KEY17% ; id fam

Gui, Main: Add, Text, x72 y165 BackgroundTrans +0x200, /startfamtimer
Gui, Main: Add, Text, x196 y165 BackgroundTrans +0x200, m
Gui, Main: Add, Text, x72 y194 w120 h14 +0x200, /listfamtimers
Gui, Main: Add, Text, x72 y223 w120 h14 +0x200, /stopfamtimer
Gui, Main: Add, Text, x72 y252 w120 h14 +0x200, /deletefamtimer
Gui, Main: Add, Text, x72 y281 w120 h14 +0x200, /feventon
Gui, Main: Add, Text, x72 y310 w120 h14 +0x200, /feventoff

;Спец.команыд
Gui, Main: Add, Hotkey, x12 y55 w57 h21 vHot4, %KEY4% ; Стрелы
Gui, Main: Add, Hotkey, x12 y84 w57 h21 vHot6, %KEY6% ; Дерби
Gui, Main: Add, Hotkey, x12 y113 w57 h21 vHot7, %KEY7% ; Вышибалы

;МП
Gui, Main: Add, Text, x72 y59 w120 h14 +0x200, Стрелы
Gui, Main: Add, Text, x72 y88 w120 h14 +0x200, Дерби
Gui, Main: Add, Text, x72 y117 w120 h14 +0x200, Вышибалы

;Нижний блок кнопок
Gui, Main: Add, GroupBox, x10 y350 w370 h9 cA52A2A, ;бокс
Gui, Main: Add, Picture, x29 y363 w80 h38 gInfo , %A_ScriptDir%\ahk\GqYwynV.png
Gui, Main: Add, Picture, x113 y363 w80 h38 gOpenSite , %A_ScriptDir%\ahk\f1P9nBu.png
Gui, Main: Add, Picture, x197 y363 w80 h38 gOpenAnotherSite , %A_ScriptDir%\ahk\Rj8QccZ.png
Gui, Main: Add, Picture, x281 y363 w80 h38 gSaveData, %A_ScriptDir%\ahk\KxTO850.png

;Выдача
Gui, Main: Tab, 4
Global Commands := []  ; Глобальный массив для хранения команд

Gui, Main: Add, GroupBox, x8 y283 w374 h27 cA52A2A,
Gui, Main: Add, Text, x109 y292 w180 h14 +0x200, Настройка панели выдачи

; Поле для ввода команд
Gui, Main:Add, Edit, vCommandInput x10 y30 w370 h255 cBlack, Введите команды здесь...
Gui, Main:Add, Button, x238 y323 w140 h21 gSaveCommands, Сохранить команды

Gui, Main: Add, Text, x76 y325 BackgroundTrans 1 +0x200, Клавиша выдачи
Gui, Main: Add, Hotkey, x12 y322 w59 h21 vHot8, %KEY8% ; клавиша выдачи

;Нижний блок кнопок
Gui, Main: Add, GroupBox, x10 y350 w370 h9 cA52A2A, ;бокс
Gui, Main: Add, Picture, x29 y363 w80 h38 gInfo , %A_ScriptDir%\ahk\GqYwynV.png
Gui, Main: Add, Picture, x113 y363 w80 h38 gOpenSite , %A_ScriptDir%\ahk\f1P9nBu.png
Gui, Main: Add, Picture, x197 y363 w80 h38 gOpenAnotherSite , %A_ScriptDir%\ahk\Rj8QccZ.png
Gui, Main: Add, Picture, x281 y363 w80 h38 gSaveData, %A_ScriptDir%\ahk\KxTO850.png
return

; ====== ЗДЕСЬ ОСНОВНОЙ КОД СКРИПТА ======
MsgBox, Скрипт запущен. Текущая версия: %CurrentVersion%
return

; Сохранение команд
SaveCommands:
    Gui, Main:Submit, NoHide
    Global Commands := StrSplit(CommandInput, "`n")
    MsgBox, Команды сохранены!
return

; выдача1
vd:
    if (Commands.Length() > 0)
    {
        WinActivate, GTA5  ; Активируем окно игры (замени на нужное название)
        Sleep, 500

        for index, command in Commands
        {
            command := Trim(command)
            if (command != "")
            {
                SendMessage, 0x50,, 0x4190419,, A
                SendInput, {T}
                Sleep, 500
                SendMessage, 0x50,, 0x4190419,, A
                SendInput, %command%+`n
                Sleep, 1000
                SendInput, {Enter} 

                Sleep, 3000  ; Задержка перед следующей командой
            }
        }
    }
    else
    {
        MsgBox, Нет сохранённых команд!
    }

Return


; === ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ===
Global ToggleFastRep := false
Global DebugMode := false
Global HotkeyName := "F10"
Global Delay := 50   ; задержка в миллисекундах

; === ГОРЯЧАЯ КЛАВИША ДЛЯ ВЫЗОВА ОКНА НАСТРОЕК ===
^!s:: ; Ctrl+Alt+S открывает окно
    Gui, Settings:New
    Gui, Settings:Add, Text,, Горячая клавиша:
    Gui, Settings:Add, Edit, vHotkeyName w100, %HotkeyName%
    Gui, Settings:Add, Text,, Задержка (мс):
    Gui, Settings:Add, Edit, vDelay w100, %Delay%
    Gui, Settings:Add, Button, gSaveSettings w100, Сохранить
    Gui, Settings:Show,, Настройки FastRep
return

SaveSettings:
    Gui, Settings:Submit
    Gui, Settings:Destroy
    
    ; Убираем старый хоткей и назначаем новый
    Hotkey, %HotkeyName%, Off
    HotkeyName := HotkeyName
    Hotkey, %HotkeyName%, ToggleFastRepHotkey, On
    
    MsgBox, Настройки сохранены!`nГорячая клавиша: %HotkeyName%`nЗадержка: %Delay% мс
return

; === ДИНАМИЧЕСКИЙ ГОРЯЧИЙ КЛЮЧ ===
ToggleFastRepHotkey:
    Global ToggleFastRep
    ToggleFastRep := !ToggleFastRep
    
    if (ToggleFastRep) {
        ToolTip, Быстрый репорт ВКЛЮЧЕН (%HotkeyName% - выключить)
        SetTimer, FastRepLoop, -1
    } else {
        ToolTip, Быстрый репорт ВЫКЛЮЧЕН (%HotkeyName% - включить)
        SetTimer, FastRepLoop, Off
    }
    SetTimer, RemoveToolTip, -1
return

; === ОСНОВНОЙ ЦИКЛ ===
FastRepLoop:
    Global ToggleFastRep, Delay
    if (!ToggleFastRep)
        return

    ; Проверяем стоп-цвет (0x181818)
    PixelGetColor, stopColor, 1130, 1013, RGB
    if (stopColor = "0x181818") {
        ToggleFastRep := false
        ToolTip, Авторепорт ОСТАНОВЛЕН (обнаружен стоп-цвет)
        SetTimer, RemoveToolTip, 2000
        SetTimer, FastRepLoop, Off
        return
    }

    ; ... твой блок проверки цветов и кликов ...

    SetTimer, FastRepLoop, -%Delay%   ; используем задержку из настроек
return

ClickSequence(x, y) {
    MouseMove, %x%, %y%, 0
    Sleep, 30
    MouseClick, left, %x%, %y%
    Sleep, 30
    MouseClick, left, %x%, %y%
    Sleep, 30
}

RemoveToolTip:
    ToolTip
return

;настройки
SaveData:
Gui, Submit, NoHide
IniWrite, %Radio1%, %A_ScriptDir%\ahk\Settings.ini, gender, gender1
IniWrite, %Radio2%, %A_ScriptDir%\ahk\Settings.ini, gender, gender2
IniWrite, %Radio8%, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /settimelocal
IniWrite, %Radio9%, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /gm
IniWrite, %Radio10%, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /dl
IniWrite, %Radio11%, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /esp3
IniWrite, %Radio12%, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /templeader
IniWrite, %Radio13%, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /chide
IniWrite, %Radio14%, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /setdim
IniWrite, %Radio15%, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /setweatherlocal extrasunny
IniWrite, %Radio16%, %A_ScriptDir%\ahk\Settings.ini, Login Commands, /togglesnow 0

IniWrite, %Hot1%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY1
IniWrite, %Hot2%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY2
IniWrite, %Hot3%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY3
IniWrite, %Hot4%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY4
IniWrite, %Hot5%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY5
IniWrite, %Hot6%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY6
IniWrite, %Hot7%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY7
IniWrite, %Hot8%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY8
IniWrite, %Hot9%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY9

IniWrite, %Hot10%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY10
IniWrite, %Hot11%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY11
IniWrite, %Hot12%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY12
IniWrite, %Hot13%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY13
IniWrite, %Hot14%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY14
IniWrite, %Hot15%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY15
IniWrite, %Hot16%, %A_ScriptDir%\ahk\Settings.ini, Binds, KEY16

IniWrite, %X%, %A_ScriptDir%\ahk\Settings.ini, Coords, X
IniWrite, %Y%, %A_ScriptDir%\ahk\Settings.ini, Coords, Y
IniWrite, %Dimension%, %A_ScriptDir%\ahk\Settings.ini, Dimension, Dimension
IniWrite, %fam%, %A_ScriptDir%\ahk\Settings.ini, fam, fam
IniWrite, %Fraction%, %A_ScriptDir%\ahk\Settings.ini, Fraction, Fraction
IniWrite, %Settimelocal%, %A_ScriptDir%\ahk\Settings.ini, Settimelocal, Settimelocal

IniWrite, %dis%, %A_ScriptDir%\ahk\Settings.ini, Discord, dis
IniWrite, %gadis%, %A_ScriptDir%\ahk\Settings.ini, Discord, gadis
IniWrite, %zgadis%, %A_ScriptDir%\ahk\Settings.ini, Discord, zgadis
Reload

;счетчик
mess: 
labelgo:
if (Radio6 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 183, 55
PixelGetColor, color, 183, 55 alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio4 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 130, 40
PixelGetColor, color, 130, 40 alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio7 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 174, 51
PixelGetColor, color, 174, 51 alt 
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio5 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 174, 51
PixelGetColor, color, 163, 51 alt 163, 51
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
return 

UpdateCounter1:
IniWrite, %DayANS%, %A_ScriptDir%\ahk\Settings.ini, ANS, DayANS
IniRead, DayANS, %A_ScriptDir%\ahk\Settings.ini, ANS, DayANS
IniWrite, %WeekANS%, %A_ScriptDir%\ahk\Settings.ini, ANS, WeekANS
IniRead, WeekANS, %A_ScriptDir%\ahk\Settings.ini, ANS, WeekANS
GuiControl,, MyText, День: %DayANS%
GuiControl,, MyTotalR, Неделя: %WeekANS%
return

UpdateCounter2:
DayANS-=1
WeekANS-=1
IniWrite, %DayANS%, %A_ScriptDir%\ahk\Settings.ini, ANS, DayANS
IniRead, DayANS, %A_ScriptDir%\ahk\Settings.ini, ANS, DayANS
IniWrite, %WeekANS%, %A_ScriptDir%\ahk\Settings.ini, ANS, WeekANS
IniRead, WeekANS, %A_ScriptDir%\ahk\Settings.ini, ANS, WeekANS
GuiControl,, MyText, День: %DayANS%
GuiControl,, MyTotalR, Неделя: %WeekANS%
return

UpdateCounter:
DayANS+=1
WeekANS+=1
IniWrite, %DayANS%, %A_ScriptDir%\ahk\Settings.ini, ANS, DayANS
IniRead, DayANS, %A_ScriptDir%\ahk\Settings.ini, ANS, DayANS
IniWrite, %WeekANS%, %A_ScriptDir%\ahk\Settings.ini, ANS, WeekANS
IniRead, WeekANS, %A_ScriptDir%\ahk\Settings.ini, ANS, WeekANS
GuiControl,, MyText, День: %DayANS%
GuiControl,, MyTotalR, Неделя: %WeekANS%
return

Reports:
sendinput, {F8} 
sleep 50
mousemove 494, 161
return

OpenSite:
    Run, https://docs.google.com/spreadsheets/d/1UNmIeS1-vYGEoT0-ScQwgDZTd4ciuIbMJXTwZhyMM7U/edit?gid=556123862#gid=556123862
return

OpenAnotherSite:
    Run, https://docs.google.com/spreadsheets/d/1lfVC-gmKEZ-zxXrh4btZdIeHB6F2P2-_HhUyw1qk1dI/edit?usp=sharing
return

	Info:
    Gui, Info: Color, 262626
    Gui, Info: Font, s12, Segoe UI
    Gui, Info: Font, cwhite
	Gui, Info: Add, Text, x8 y8  h23 +0x200,AHK создан для облегчения работы администрации.
    Gui, Info: Add, Text, x8 y32  h23 +0x200, 
    Gui, Info: Add, Text, x8 y56  h23 +0x200,AHK автоматически считает кол-во отвеченных репортов в день и в неделю,
    Gui, Info: Add, Text, x8 y80  h23 +0x200,если в меню репорта написать .ку
    Gui, Info: Add, Text, x8 y104  h23 +0x200,
    Gui, Info: Add, Text, x8 y124  h23 +0x200, Для корректной работы AHK рекомендуется указать
    Gui, Info: Add, Text, x8 y148  h23 +0x200, ваш пол, свой дискр, дискор га и зга.
    Gui, Info: Add, Text, cred x8 y196  h23 +0x200, Хоткеи:
	Gui, Info: Add, Text, x8 y220  h23 +0x200,Ctrl + F9 - Перезапустить.
    Gui, Info: Add, Text, x8 y244  h23 +0x200,Ctrl + F10 - Закрыть.
    Gui, Info: Add, Text, x8 y292  h23 +0x200, Если что-то сломалось/не работает/есть идеи и т.п. писать - dbleck23
    Gui, Info: Show, h360 w570, Информация
    Gui, Info: Color, 262626
	Return

;====

startfamtimer:
sleep 150
SendInput, {t}
sleep 150
SendInput, /startfamtimer %famid% %radius% 120
return

listfamtimers:
sleep 150
SendInput, {t}
sleep 150
SendInput, /listfamtimers{enter}
return

stopfamtimer:
sleep 150
SendInput, {t}
sleep 150
SendInput, /stopfamtimer{space}
return

continuefamtimer:
sleep 150
SendInput, {t}
sleep 150
SendInput, /continuefamtimer{space}
return

deletefamtimer:
sleep 150
SendInput, {t}
sleep 150
SendInput, /deletefamtimer{space}
return

feventon:
Sleep 150
BlockInput, SendAndMouse
SendInput, {t}
Sleep 150
SendInput, /feventon %famid%{space}
return

feventoff:
Sleep 150
BlockInput, SendAndMouse
SendInput, {t}
Sleep 150
SendInput, /feventoff %famid%
return

;====

; Spawn cars for clash of arrows
strel:
coords := [ "1322.335 3166 40", "1323.645 3161.631 40", "1324.868 3156.753 40", "1326.279 3152.227 40", "1327.381 3147.303 40", "1328.679 3142.537 40", "1330.351 3137.679 40", "1331.435 3132.999 40", "1205.05 3132.86 40", "1206.50 3128.19 40", "1207.57 3123.31 40", "1208.80 3118.48 40", "1209.97 3113.53 40", "1211.49 3108.63 40", "1212.92 3103.74 40", "1214.29 3098.85 40" ]
for index, coord in coords {
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {T}
    Sleep, 400
    SendInput, /ctp %coord%{Enter}
    Sleep, 400
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {T}
    Sleep, 400
    SendInput, /veh taycan{Enter}
    Sleep, 400
    SendInput, {L}
    Sleep, 400
}
Return

; Spawn cars for clash of arrows
ar:
coords := [ "335.964 34.881 90.306", "337.785 39.772 91.424","339.524 45.718 92.720","340.392 50.803 93.803","342.119 56.149 94.946","951.294 -1791.919 32.457","950.615 -1800.514 32","949.94 -1807.28 32","949.23 -1814.99 32","948.66 -1821.97 32","-44.93 -1806.61 28","-50.78 -1801.93 28","-56.64 -1797.23 28","-60.93 -1793.80 28","-66.42 -1789.45 28","669.27 655.70 130","675.14 652.96 130","682.27 649.95 130","688.71 647.18 130","694.22 644.80 130","1302.87 1179.16 108","1302.88 1172.43 108","1302.92 1167.30 108","1302.89 1161.93 108","1302.92 1154.16 108","957.28 -143.48 76","962.19 -146.61 76","967.20 -149.79 76","972.12 -152.91 76","977.03 -156.48 76","976.30 -2470.87 30","971.06 -2470.27 30","965.27 -2469.61 30","959.57 -2468.96 30","953.97 -2468.37 30"]
for index, coord in coords {
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {T}
    Sleep, 400
    SendInput, /ctp %coord%{Enter}
    Sleep, 400
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {T}
    Sleep, 400
    SendInput, /veh taycan{Enter}
    Sleep, 400
    SendInput, {L}
    Sleep, 400
}
Return

; === ФУНКЦИЯ ПОВОРОТА КАМЕРЫ ===
TurnCamera(angle) {
    factor := 6
    dx := Round(angle * factor)

    step := (dx > 0 ? 20 : -20)  ; шаг по 20 пикселей
    while (Abs(dx) > Abs(step)) {
        DllCall("mouse_event", "UInt", 0x0001, "Int", step, "Int", 0, "UInt", 0, "UPtr", 0)
        dx -= step
        Sleep, 15
    }
    ; добиваем остаток
    if (dx != 0) {
        DllCall("mouse_event", "UInt", 0x0001, "Int", dx, "Int", 0, "UInt", 0, "UPtr", 0)
    }
}

; === ОСНОВНОЙ СКРИПТ ===
derb:

coords := ["3040 -4568.21 15", "3037.23 -4568.73 15",  "3034.12 -4570.03 15", "3029.83 -4570.98 15", "3025.13 -4572.49 15", "3021.66 -4573.54 15", "3018.42 -4574.73 15", "3014.77 -4575.69 15","3087.505 -4811.254 15", "3093.481 -4808.721 15", "3101.296 -4805.409 15", "3106.813 -4803.071 15","3088.01 -4717.32 14.61", "3095.18 -4720.91 14.61", "3101.45 -4720.23 14.61", "3089.13 -4685.09 15.41" ]

phantomCoords := [ "3087.505 -4811.254 15", "3093.481 -4808.721 15", "3101.296 -4805.409 15", "3106.813 -4803.071 15" ]

tankerCoords := [ "3088.01 -4717.32 14.61", "3095.18 -4720.91 14.61", "3101.45 -4720.23 14.61", "3089.13 -4685.09 15.41"]

for index, coord in coords {
    cleanCoord := Trim(coord)

    ; телепорт к координате
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {T}
    Sleep, 400
    SendInput, /ctp %cleanCoord%{Enter}
    Sleep, 400
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {T}
    Sleep, 1000

    ; проверка на фантомные координаты
    foundPhantom := false
    for _, pCoord in phantomCoords {
        if (cleanCoord = Trim(pCoord)) {
            foundPhantom := true
            break
        }
    }

    ; проверка на танкеры
    foundTanker := false
    for _, tCoord in tankerCoords {
        if (cleanCoord = Trim(tCoord)) {
            foundTanker := true
            break
        }
    }

    ; выбор спавна
    if (foundPhantom) {
        SendInput, /veh phantom2 67 67{Enter}
        Sleep, 200
    } else if (foundTanker) {
        SendInput, /veh tankercar{Enter}
        Sleep, 200
    } else {
        SendInput, /rveh matiz 135 135 4 4{Enter}
    }

    ; --- ДОП. УСЛОВИЯ ДЛЯ ПОВОРОТА КАМЕРЫ ---
    ; фантом на 3087.505 -4811.254 15
    if (cleanCoord = "3087.505 -4811.254 15") {
        Sleep, 300
        TurnCamera(-790)
        SoundPlay, *64
    }
    ; танкер на 3088.01 -4717.32 14.61
    if (cleanCoord = "3088.01 -4717.32 14.61") {
        Sleep, 300
        TurnCamera(400)
        SoundPlay, *64
    }

    Sleep, 400
}

; финальные команды
SendMessage, 0x50,, 0x4190419,, A
SendInput, {T}
Sleep, 400
SendInput, /ctp 3032.748 -4703.704 15{Enter}
Sleep, 400
SendMessage, 0x50,, 0x4190419,, A
SendInput, {T}
Sleep, 400
SendInput, /eventon{Enter}
Return


; Spawn cars for clash of arrows
vb:
coords := [ "-268 -736 125", "-266.730 -731.052 125", "-293.955 -728.136 123" ]

for index, coord in coords {
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, {T}
    Sleep, 400
    SendInput, /ctp %coord%{Enter}
    Sleep, 500

    if (coord != "-293.955 -728.136 123") {
        SendMessage, 0x50,, 0x4190419,, A
        SendInput, {T}
        Sleep, 400
        SendInput, /veh bdivo 135 135{Enter}
    } else {
        SendMessage, 0x50,, 0x4190419,, A
        SendInput, {T}
        Sleep, 400
        SendInput, /eventon{Enter}
    }

    Sleep, 400
}
Return


repm:
counter++
GoSub, UpdateCounter2
Clipboard :=
return

rep:
counter++
GoSub, UpdateCounter
Clipboard :=
return

mtp:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 150
SendInput, /specoff{Enter}
Sleep 300
SendInput, {F5}
return

vhod:
SendMessage, 0x50,, 0x4090409
if (Radio12==1)
{
SendInput, {T}
Sleep 300
SendInput, /templeader %Fraction%{Enter}
Sleep 300
}
if (Radio9==1)
{
SendInput, {T}
Sleep 300
SendInput, /gm{Enter}
Sleep 300
}
if (Radio11==1)
{
SendInput, {T}
Sleep 300
SendInput, /esp3{Enter}
Sleep 300
}
if (Radio13==1)
{
SendInput, {T}
Sleep 300
SendInput, /chide{Enter}
Sleep 300
}
if (Radio8==1)
{
SendInput, {T}
Sleep 300
SendInput, /settimelocal %Settimelocal%{Enter}
Sleep 300
}
if (Radio10==1)
{
SendInput, {T}
Sleep 300
SendInput, /dl{Enter}
Sleep 300
}
if (Radio14 == 1)
{
    SendInput, {T}
    Sleep 300
    SendInput, /setdim  %Dimension%{left 3}
    
    Loop
    {
        Sleep 100
        if GetKeyState("Enter", "P")
            break
    }

    Loop
    {
        Sleep 50
        if !GetKeyState("Enter", "P")
            break
    }
}
if (Radio15==1)
{
SendInput, {T}
Sleep 300
SendInput, /setweatherlocal extrasunny{Enter}
Sleep 300
}
f (Radio16==1)
{
SendInput, {T}
Sleep 300
SendInput, /togglesnow 0{Enter}
Sleep 300
}
return

;Телепорты
:?:.авио::/ctp 3050.618 -4681.522 15.261
:?:/fdbj::/ctp 3050.618 -4681.522 15.261
:?:.остров::/ctp 4998.114 -5731.152 19.880
:?:/jcnhjd::/ctp 4998.114 -5731.152 19.880
:?:/cfyu::/ctp -2270.247 3286.152 41.688
:?:.санг::/ctp -2270.247 3286.152 41.688
:?:.крыша::/ctp -267.301 -736.295 123.997
:?:/rhsif::/ctp -267.301 -736.295 123.997
:?:/gl::/ctp 429 -980 30.50
:?:/vjhu::/ctp 250 -1368 39
:?:.морг::/ctp 250 -1368 39
:?:.клп::/ctp -196.836 6218.708 31.491 
:?:.клс::/ctp 1728.313 3717.568 34.109
:?:.клм::/ctp -361.424 -129.636 38.696
:?:.клг::/ctp -40.529 -1077.648 26.653
:?:.м15::/ctp -698.316 -386 34
:?:.v15::/ctp -698.316 -386 34

:?:/gl::/ctp 429 -980 30.50
:?:.пд::/ctp 429 -980 30.50
:?:/ems::/ctp 1155 -1524 34
:?:.емс::/ctp 1155 -1524 34
:?:/tvc::/ctp 1155 -1524 34
:?:.шд::/ctp -434.87 6024.54 31.50
:?:.шд2::/ctp 1843.770 3666.384 33.760
:?:.фз::/ctp -2336 3257 32.50
:?:.мэр::/ctp -534.70 -222.07 37.60
:?:.визл::/ctp -593 -929 24
:?:.фиб::/ctp 2527 -377 93

:?:.бал::/ctp -70.06 -1824.64 26.94
:?:.ваг::/ctp 967 -1817 31
:?:.фэм::/ctp -204.29 -1513.69 31.60
:?:.бладс::/ctp 496 -1330 29.40
:?:.мара::/ctp 1009 -2520 28

:?:.лкн::/ctp 1385 1154 114.40
:?:.рм::/ctp -1526 858 181
:?:.яки::/ctp -1556.36 113.07 57
:?:.мекс::/ctp 381.03 23.12 91.40
:?:.ам::/ctp -1895.23 2027.19 141

:?:.лост::/ctp 969.84 -128.40 74.40
:?:.аод::/ctp 1995.99 3062.44 47.06

:?:.груб::/ctp -3022 105 11.30
:?:.клаб::/ctp 1588.65 6445.38 25
:?:.рич::/ctp -1302.49 294.52 64.50
:?:.манор::/ctp -58.20 343.73 111.80
:?:.конт::/ctp -1865.51 -355.96 57

:?:.хум::/ctp 3569.54 3789.48 30
:?:.техи::/ctp 180 -2847 20
:?:.меды::/ctp 185 -2575 21
:?:.мейз::/ctp -75 -818 326
:?:.каз::/ctp 916 50 81
:?:.аш::/ctp -620 -2264 6
:?:.гг::/ctp -257 -2023 30
:?:.бургер::/ctp -1171.31 -890.20 13.90
:?:.багама::/ctp -1391.30 -585.35 30
:?:.кайо::/ctp 4488.58 -4493.52 4
:?:.авиа::/ctp 3035.21 -4688.55 15
:?:.мол::/ctp 61.67 -1751.80 47
:?:.трас::/ctp 7400 3946 1124
:?:.трасс::/ctp 7400 -656 1124
:?:.аук::/ctp -833 -699.50 27
:?:.бокс::/ctp 8.56 -1658.55 28.71
:?:.бар::/ctp -305.09 6259.59 30.92
:?:.бк::/ctp 500.44 109.79 96.49
:?:.ванила::/ctp 131.33 -1302.93 29.23
:?:.починка::/ctp -1430.45 -450.5 35.91
:?:.лск4::/ctp 1175.47 2671.33 37.85
:?:.порт::/ctp 417 -2501 13.46
:?:.стр::/ctp 1304 1453 98.87
:?:.лес::/ctp -321 6093 31.14
:?:.бмара::/ctp 1302 -1646 51.04
:?:.самол::/ctp 1473 2730 37.38
:?:.чил::/ctp 498 5592 795
:?:.чилл::/ctp 747.413 1187.995 347.968
:?:.сэнди::/ctp 1843.770 3666.384 33.760
:?:.палето::/ctp -434.87 6024.54 31.50

:?:/rkg::/ctp -196.836 6218.708 31.491 
:?:/rkc::/ctp 1728.313 3717.568 34.109
:?:/rkv::/ctp -361.424 -129.636 38.696
:?:/rku::/ctp -40.529 -1077.648 26.653 

:?:/kcgl::/ctp 429 -980 30.50
:?:/,jk::/ctp 1155 -1524 34
:?:/il::/ctp -434.87 6024.54 31.50
:?:/il2::/ctp 1843.770 3666.384 33.760
:?:/ap::/ctp -2336 3257 32.50
:?:/v'h::/ctp -534.70 -222.07 37.60
:?:/dbpk::/ctp -593 -929 24
:?:/ab,::/ctp 2527 -377 93

:?:/,fk::/ctp -70.06 -1824.64 26.94
:?:/dfu::/ctp 967 -1817 31
:?:/a'v::/ctp -204.29 -1513.69 31.60
:?:/,kflc::/ctp 496 -1330 29.40
:?:/vfhf::/ctp 1009 -2520 28 

:?:/kry::/ctp 1385 1154 114.40
:?:/hv::/ctp -1526 858 181
:?:/zr::/ctp -1556.36 113.07 57
:?:/vtrc::/ctp 381.03 23.12 91.40
:?:/fv::/ctp -1895.23 2027.19 141
:?:/bh::/ctp -3028.926 100.118 11.614

:?:/kjcn::/ctp 969.84 -128.40 74.40
:?:/ajl::/ctp 1995.99 3062.44 47.06

:?:/[ev::/ctp 3569.54 3789.48 30
:?:/vtqp::/ctp -75 -818 326
:?:/rfp::/ctp 916 50 81
:?:/fi::/ctp -620 -2264 6
:?:/uu::/ctp -257 -2023 30
:?:/,ehuth::/ctp -1171.31 -890.20 13.90
:?:/,fufvf::/ctp -1391.30 -585.35 30
:?:/rfqj::/ctp 4488.58 -4493.52 4
:?:/fdbf::/ctp 3035.21 -4688.55 15
:?:/vjk::/ctp 61.67 -1751.80 47
:?:/nhfc::/ctp 7400 3946 1124
:?:/nhfcc::/ctp 7400 -656 1124
:?:/fec::/ctp -833 -699.50 27
:?:/,jrc::/ctp 8.56 -1658.55 28.71
:?:/,fh::/ctp -305.09 6259.59 30.92
:?:/,r::/ctp 500.44 109.79 96.49
:?:/dfybkf::/ctp 131.33 -1302.93 29.23
:?:/gjxbyrf::/ctp -1430.45 -450.5 35.91
:?:/kcr4::/ctp 1175.47 2671.33 37.85
:?:/gjhn::/ctp 417 -2501 13.46
:?:/cnh::/ctp 1304 1453 98.87
:?:/ktc::/ctp -321 6093 31.14
:?:/,vfhf::/ctp 1302 -1646 51.04
:?:/cfvjk::/ctp 1473 2730 37.38
:?:/xbk::/ctp 498 5592 795
:?:/c'ylb::/ctp 1843.770 3666.384 33.760
:?:/gfktnj::/ctp -434.87 6024.54 31.50
:?:.гов::/ctp -542.690 -207.905 37.650
:?:/ujd::/ctp -542.690 -207.905 37.650
:?:.ириш::/ctp -3015.069 91.910 11.614
:?:/bhbi::/ctp -3015.069 91.910 11.614

:?:.дим::
{
    SendMessage, 0x50,, 0x4190419,, A
    SendInput, /setdim  %Dimension%{left 3}
}
Return

;Команд
:?:.лид12::/templeader 12
:?:.лид11::/templeader 11
:?:.лид10::/templeader 10
:?:.лид9::/templeader 9
:?:.лид8::/templeader 8
:?:.лид7::/templeader 7
:?:.лид6::/templeader 6
:?:.лид5::/templeader 5
:?:.лид4::/templeader 4
:?:.лид3::/templeader 3
:?:.лид2::/templeader 2
:?:.лид1::/templeader 1
:?:.акфтпу::/frange 400
:?:.зкфтпу::/prange 400
:?:.код::/mark ПОХИЩЕНИЕ
:?:.ь::/m
:?:.ы::/s
:?:.сез::/ctp
:?:/esp4::/netstat
:?:.уыз4::/netstat
:?:.зфн::/pay
:?:.уыз3::/esp3
:?:.время::/settimelocal
:?:/dhtvz::/settimelocal
:?:/вудмур::/delveh
:?:.делвех::/delveh
:?:.мурыефе::/vehstat
:?:.вехстат::/vehstat
:?:/fyrfa::/auncuff
:?:.анкаф::/auncuff
:?:.каф::/acuff
:?:/rfa::/acuff
:?:/bc::/bancheck
:?:.ис::/bancheck
:?:/jc::/ajailcheck 
:?:.ос::/ajailcheck 
:?:.ифтсрусл::/bancheck
:?:.фофшдсрусл::/ajailcheck 
:?:/tf::/tempfamily 
:?:.еа::/tempfamily 
:?:/sm::/setmaterials 
:?:.ыь::/setmaterials 
:?:/tn::/tempname
:?:.ет::/tempname 
:?:.еуьзтфьу::.еуьзтфьу 
:?:.яяв::/zzdebug 
:?:/zzd::/zzdebug 
:?:/Usefull::/addUsefullitheater 
:?:.фьзр::/addUsefullitheater 
:?:/rUsefull::/removeUsefullitheater 
:?:.кфьзр::/removeUsefullitheater 
:?:/gzone::/togglegreenzone 
:?:.пящту::/togglegreenzone 
:?:/mc::/mutecheck 
:?:.ьс::/mutecheck 
:?:.ьгеусрусл::/mutecheck 
:?:.гтофшд::/unjail 
:?:.цфкт::/warn 
:?:/ld::/lastdriver 
:?:.дв::/lastdriver 
:?:/af::/ainfect 
:?:.фа::/ainfect 
:?:/sk::/skick 
:?:.ыл::/skick 
:?:/k::/kick 
:?:.л::/kick 
:?:/ai::/auninvite 
:?:.фш::/auninvite 
:?:.аи::/fb 
:?:/aif::/ainfect  
:?:.фша::/ainfect 
:?:.с::/c  
:?:.си::/cb 
:?:.гтьгеу::/unmute 
:?:.пшв::/gid 
:?:.фвьшты::/admins{enter} 
:?:.фштаусе::/ainfect 
:?:.умутещт::/eventon 
:?:.умутещаа::/eventoff 
:?:.пц::/gw 
:?:.мур::/veh 
:?:.ашчсфк::/fixcar 
:?:.уьздуфвук::/templeader 
:?:/tl::/templeader 
:?:.ед::/templeader 
:?:.ылшсл::/skick 
:?:.кузфшк::/repair 
:?:.фгтшмшеу::/auninvite 
:?:.учсфк::/excar 
:?:.агуд::/fuel 
:?:.багажник::/pulltrunk 
:?:.акууя::/freez 
:?:.езсфк::/tpcar 
:?:.дфыевкшмук::/lastdriver 
:?:.вудшеуь::/delitem 
:?:/gc::/getcar 
:?:.пс::/getcar 
:?:.фв::/admins{enter} 
:?:/ad::/admins{enter} 
:?:.з::/players 
:?:/p::/players 
:?:.здфнукы::/players 
:?:.рес::/rescue 
:?:/htc::/rescue 
:?:.ез::/tp 
:?:.ызус::/spec 
:?:.ызусщаа::/specoff {Enter} {F5}
:?:.фыьы::/asms 
:?:.ф::/a 
:?:/sp::/spec 
:?:.ыз::/spec 
:?:/so::/specoff {Enter} {F5}
:?:.ыщ::/specoff {Enter} {F5}
:?:.килл::/hp 0{left 2}
:?:.рз::/hp 0{left 2}
:?:/kill::/hp 0{left 2}
:?:.лшдд::/hp 0{left 2}
:?:.штсфк::/incar 
:?:.пр::/gh 
:?:.пиздец::<@&1118255513046614137> и <@&1118255559221727322>. Уважаемая администрация, просим зайти вас на сервер, в данный момент нам очень нужна ваша помощь.
:?:.штм::/inv 
:?:.шв::/id 
:?:.од::/ajail 
:?:.фофшд::/ajail 
:?:.лшсл::/kick 
:?:.ылшсл::/skick 
:?:.кузфшк::/repair 
:?:.вд::/dl 
:?:.уыз::/esp3 
:?:.пуесфк::/getcar 
:?:.ифт::/ban 
:?:.вудмур::/delveh 
:?:.ьез::/mtp 
:?:.мур::/veh 
:?:.фмур::/aveh 
:?:.рфквифт::/hardban 
:?:.ьгеу::/mute 
:?:.пшв::/gid 
:?:.ср::/chide 
:?:/ch::/chide 
:?:.куысгу::/rescue 
:?:.ыуевшь::/setdim 
:?:/sd::/setdim 
:?:.и::/b 
:?:.ц::/w 
:?:.ыв::/setdim 
:?:.сршву::/chide 
:?:.афк::/a афк мин{left 4}
:?:/far::/a афк мин{left 4}
:?:.фгтсгаа::/auncuff 
:?:.фсгаа::/acuff 
:?:.акууяу::/freeze
:?:/scd::/setcardim 
:?:.ыуесфквшь::/setcardim 
:?:.ысв::/setcardim 
:?:/rst::/resettempname 
:?:.кые::/resettempname 
:?:.куыуееуьзтфьу::/resettempname 
:?:.ты::/netstat 
:?:/ns::/netstat 
:?:.вм::/delveh 
:?:/dv::/delveh 
:?:/hard::/hardban 
:?:.рфкв::/hardban 
:?:/as::/asms 
:?:.фы::/asms 
:?:.пез::/gtp
:?:.пь::/gm
:?:.ылшт::/skin
:?:.езр::/tph
:?:.фмур::/aveh
:?:.фдщсл::/alock
:?:.гти::/unban 
:?:/unb::/unban
:?:.гто::/unjail
:?:/unj::/unjail
:?:/dvr::/delvehrange 
:?:.вмк::/delvehrange 
:?:.щи::/objdl
:?:/ob::/objdl

:?:.краш::
SendMessage, 0x50,, 0x4090409
SendInput, Если у Вас есть доказательства краша - предоставьте его мне в личные сообщения дискорда. Я вас выпущу. Мой дискорд: %dis%.
Return

:?:.дс::
SendMessage, 0x50,, 0x4090409
SendInput, Предоставьте видео доказательство мне в личные сообщения дискорда:  %dis% .
Return

:?:.га::
SendMessage, 0x50,, 0x4090409
SendInput, Обратитесь в личные сообщения дискорда к главному администратору: %gadis% .
Return

:?:.зга::
SendMessage, 0x50,, 0x4090409
SendInput, Обратитесь в личные сообщения дискорда к заместителю главного администратора: %zgadis% .
Return

:?:.дсс::
SendMessage, 0x50,, 0x4090409
SendInput, Обратитесь ко мне в личные сообщения дискорда: %dis%.
Return

:?:/rhfi::
SendMessage, 0x50,, 0x4090409
SendInput, Если у Вас есть доказательства краша - предоставьте его мне в личные сообщения дискорда. Я вас выпущу. Мой дискорд: %dis%.
Return

:?:/lc::
SendMessage, 0x50,, 0x4090409
SendInput, Предоставьте видеодоказательство мне в личные сообщения дискорда: %dis% . 
Return

:?:/lc2::
SendMessage, 0x50,, 0x4090409
SendInput, Предоставьте видеодоказательство любому администратору в личные сообщерния дискорда.
Return

:?:/uf::
SendMessage, 0x50,, 0x4090409
SendInput, Обратитесь в личные сообщения дискорда к главному администратору: %gadis% .
Return

:?:/puf::
SendMessage, 0x50,, 0x4090409
SendInput, Обратитесь в личные сообщения дискорда к заместителю главного администратора: %zgadis% .
Return

:?:/lbc::
SendMessage, 0x50,, 0x4090409
SendInput, Обратитесь ко мне в личные сообщения дискорда: %dis%.
Return

;Пол
IniRead, Radio1, %A_ScriptDir%\ahk\Settings.ini, gender, gender1
IniRead, Radio2, %A_ScriptDir%\ahk\Settings.ini, gender, gender2

if (Radio1 = "ERROR" && Radio2 = "ERROR") {
    Radio1 := 1
    Radio2 := 0
}

; Определяем переменную gender
if (Radio1 = "1") {
    Radio2 := 0
    gender := ""  ; Мужской
}
if (Radio2 = "1") {
    Radio1 := 0
    gender := "а"  ; Женский
}


;Ru Ответы
:?:.капт::Капты проводятся в понедельник, среду, пятницу, воскресенье. С 14:00 по 21:00. 
:?:.бин:: Для использования бинокля, положите его в слот активного предмета, после нажмите ПКМ.
:?:.мода::Для того что бы выполнить задание "показ мод" вам нужно приехать на 15 магазин одежды, в планшете в вкладке "одежда и аксессуары" выберете одежду которые вам нравится и нажмите на кнопку "примерить".
:?:.лифт::Можете прокатайтся на любом лифте, например в Weazel-News или Government
:?:.проверка::/asms  Приветствую. Вы были вызваны на проверку  использования стороннего ПО. У вас есть несколько минут, чтобы перейти в голосовой канал в официальном Discord-сервере Cheats Hunters проекта discord.gg/chmajestic. Отказ от проверки или выход из игры карается блокировкой.
:?:/l::Доброй ночи и хорошего настроения{!}
:?:.д::Доброй ночи и хорошего настроения{!}
:?:/vprh::Могу закрывать ваш репорт?
:?:/yp::Не за что, могу еще чем то помочь?
:?:.мзкр::Могу закрывать ваш репорт?
:?:.нз::Не за что, могу еще чем то помочь?
:?:.тикет::В репорт тикет принимается следующие нарушения: Нарушение игровых чатов, Db, NRD\NrpFly, Sk, Crime GZ.
:?:.актуал::Приносим извинения за столь долгое ожидание. Пожалуйста, если проблема еще актуальна, продублируйте её в своем обращении. Спасибо за понимание.
:?:.долго::Вы долго не отвечали, закрываю репорт.
:?:.невид::Не видя полной ситуации, не могу выдать наказание игроку.
:?:.имя::Напишите именной репорт на имя администратора, который выдал вам наказание.
:?:.мг::Могу еще чем то вам помочь ?
:?:.кур::Передам кураторам.
:?:.неоф::Не оффтопьте в обращения.
:?:.непр::Не предоставляем подобную информацию.
:?:.хз::Не владеем данной информацией.
:?:.хз2::Не владеем данной информацией. Следите за новостями.
:?:.багс::Рестарт был, но задания не обновились, видимо какой то баг, ожидайте исправления.
:?:.имя::Закройте и напишите новый именной репорт , на имя Администратора , который выдал вам наказание .
:?:.био::На сервере существует 3 вида Биодобавки. Эффект Биодобавки ускоряет прокачку рабочих навыков в 2 раза. Биодобавка 1 уровня - действует - 30 минут , Биодобавка 2 уровня - действует - 60 минут ,Биодобавка 3 уровня - действует - 120 минут.
:?:/prh::Закрываю репорт?
:?:.зкр::Закрываю репорт?
:?:.чит::Предоставьте доказательства любому администратору с ролью Cheat Hunter в личные сообщения в дискорде.
:?:.бб::Вы вышли с сервера, закрываю репорт.
:?:.сид::Укажите static ID нарушителя.
:?:.ид::Укажите, пожалуйста, ID нарушителя.
:?:.виз::Визуальный баг, перезайдите на сервер.
:?:.баг::Знаем о данной проблеме, она уже передана разработчикам. Приносим свои извинения за предоставленные неудобства.
:?:.рп::Извините, но это РП процесс, мы не вправе вмешиваться в него.
:?:.урп::Данную информацию вы можете получить при взаимодействии с другими игроками/самостоятельным поиском непосредственно во время игрового процесса, либо другим доступным IC путем. 
:?:.тех::Напишите в технический раздел на форуме.
:?:.техдс::Напишите в технический раздел официального дискорд сервера "Помощь по игре" - "тех-поддержка".
:?:.увал::К сожалению, ничем не можем помочь, увольняем только в случае, если у фракции нет лидера. Дождитесь своего лидера/заместителей.
:?:.релог::У вас баг, вам нужно перезайти на сервер.
:?:.нак::Игрок получил наказание.
:?:.п16::администрация не разглашает подробности наказаний по данному/иным пунктам ПС. вы можете самостоятельно ознакомиться с информацией в документе пользовательского соглашения проекта https://majestic-rp.ru/user-agreement.pdf
:?:.жб::Администрация не может выдавать наказания и выносить какие-либо вердикты не видя всей ситуации с самого начала. Пожалуйста, если у Вас есть видеофиксация данного нарушения - оформите жалобу на форуме, спасибо большое за понимание.
:?:.анак::Обратитесь, пожалуйста, в дискорд к администратору, который выдал вам наказание или рассмотрел жалобу.
:?:.адз::Данный администратор сейчас занят другим делом или отошел от компьютера на короткое время, напишите ему в личные сообщения в дискорде.
:?:.адс::Данный администратор сейчас отсутствует на сервере, напишите ему в личные сообщения в дискорде.
:?:.донат::Обратитесь по почте - help@majestic-rp.ru.
:?:.п::Приятной игры и хорошего настроения{!}
:?:.нов::Следите за новостями сервера в официальном дискорде проекта. 
:?:.ново::Следите за новостями в официальном дискорде проекта. 
:?:.сделка::Администрация не следит за сделками игроков, запишите видео на случай обмана, чтобы оставить жалобу на игрока на форуме. 
:?:.багзз::Чтобы восстановить прежнюю скорость, заедьте в зеленую зону и выедьте с нее.
:?:.кредит::Любые финансовые договоры (займы, кредиты и т.д) не относятся к ООС сделкам. Все подобные сделки игроки совершают на свой страх и риск. Администрация не несет ответственности и не является гарантом сделки.
:?:.погода::К сожалению администрация не контролирует данный процесс. Погода меняется автоматически. 
:?:.реп::Пожалуйста, уточните свой вопрос подробнее. Администрация не летает на репорты по типу "админ тп", "админ можно поговорить", "помогите", "админ есть вопрос", "последите", Количество символов неограничено, вы можете полностью расписать Вашу проблему/вопрос.
:?:.наг::Сейчас большая нагрузка на сервере оставьте жалобу на Forum или чуть позже в репорт. Надеемся на понимание и просим прощения за предоставленные неудобства.
:?:.неувид::К сожалению администрация не может увидеть это нарушение. Пожалуйста, если у Вас есть видеофиксация данного нарушения - оформите жалобу на форуме, спасибо большое за понимание.
:?:.нетп::Администрация не телепортирует игроков, Вам нужно добраться до места самостоятельно. На проекте достаточно способов, чтобы это сделать: такси, аренда транспорта, автосервисы.
:?:.инв::Это баг инвентаря, предложите обменяться любому игроку и ваша проблема будет решена. Если по близости никого нет, обратитесь ещё раз в репорт и администрация Вам поможет. 
:?:.несл::Администрация не может следить полностью за всем РП процессом, в случае нарушений от игроков - напишите репорт.
:?:.аут::Для подключения Google authenticator вам нужно в меню выбора персонажа открыть раздел настроек.
:?:.вод::Администрация не достает автомобили из воды, а лишь удаляет, чтобы вы могли ее заспавнить. Вам необходимо самостоятельно добраться до автосервиса/аренды т.с или до нужного вам места, например, вы можете вызвать такси.
:?:.бенз::Администрация не заправялет т.с. игроков. Вы можете вызвать такси и добраться до нужного вам места или приобрести канистру, чтобы в дальнейшем доехать до АЗС.
:?:.удал::Администрация не удаляет т.с. игроков. Исключение: т.с. утонуло и не исчезло.
:?:.фор::Данное нарушение не подлежит рассмотрению через обращение, оставьте жалобу на форуме.
:?:.фжб::Не могу рассмотреть из-за нарушений правил подачи. Автору репорт-жалобы необходимо указывать в названии видео: свой static, static нарушителя, время и дату. Измените название и продублируйте вашу репорт-жалобу.
:?:.зак::Это регламентируется IC законами, Мы не консультируем по ним. Изучить их можете в разделе Government на форуме.
:?:.пго18::Информацию о разрешённой одежды для сотрудника Гос. Организаций можете найти в таблице которую можно найти в 1.19 Правила государственных организаций.
:?:.багдс::Оставьте свой баг-репорт в официальном дискорде проекта: Текстовые каналы - сообщить о баге.
:?:.пейдей::PayDay приходить каждый час и начисляет зарплату во фракции, если же вы не состоите во фракции, вам будет начисляться пособие по безработице.
:?:.угон::Для угона транспортного средства, вам необходимо турбо декодер и программатор ЭБУ.
:?:.клвл::При достижении 5-го уровня: 500 MC При достижении 10-го уровня: 1000 MC При достижении 15-го уровня: 2000 MC При достижении 20-го уровня: 3000 MC При достижении 25-го уровня: 4000 MC При достижении 30-го уровня: 5000 MC. Каждый следующий уровень после 30-го Вы будете получать 1500 MC. 
:?:.квест::На сервере доступны Мировые и Личные квесты. Ознакомиться с ними можно на рынке (На карте обозначен как "Красный вопрос"). Квесты доступны всем. Личные квесты вы можете проходить неопределенный срок, но, если Вы захотите участвовать в Мировом квесте и получить дополнительные бонусы, то Вам нужно поторопиться выполнить личный квест. Только 5 лучших игроков смогут попасть в топ 3 и залутать дополнительные бонусы. - Каждую неделю доступно по 3 личных и мировых квеста. - Некоторые квесты по типу инкасатора/мусорщика/почтальона можно выполнять в 2-ем и более, засчитывать будем всем.
:?:.фед::На первом этаже стоит NPC у которого можно взять задание. Чтобы отбыть срок в федеральной тюрьме, нужно выполнять задачи. Например помыть туалет - В определенное время тюрьма закрывает клетки на 5 минут, соответственно, в это время отбыть срок нельзя: -- Открываются клетки в 00 минут -- Закрываются клетки в 20 минут на 5 минут -- Открываются клетки в 25 минут -- Закрываются клетки в 55 минут на 5 минут.
:?:.сейф::Закрывать интерфейс сейфа можно только на ESC. В сейф можно класть до 5 миллионов. Деньги идут из налички. Нельзя продать дома в гос, продать игроку, предложить обмен, выставить на аукцион, если в сейфе есть деньги. Сначала требуется их забрать. Если дом слетает по налогам - деньги из сейфа игрок получает в наличку. 
:?:.майки::Для того, чтобы купить майку под верхнюю одежду, вам нужно сначала купить элемент верхней одежды (например, пиджак). После этого вам буду доступны все майки, которые подходят под нее в разделе "Майки".
:?:.фам::/c - IC чат, /cb - OOC чат. 
:?:.фрак::/f - IC чат, /fb - OOC чат. 
:?:.оружлиц::Получить лицензию на оружие можно в LSPD или LSCSD. 
:?:.кан::Чтобы использовать канистру, возьмите её в руки, нажмите G на авто и заправить. 
:?:.емс::К сожалению, администрация не поднимает и не лечит игроков, воспользуйтесь услугами ЕМС.
:?:.ремонт::Для начала, Вам нужно купить запчасть для машины на любо АЗС, после чего открыть капот , нажать G > Починить замок/аккумулятор/залить масло. 
:?:.свалка::Вы можете сдать авто на свалку. После сдачи вы получите 75% от гос. стоимости авто. Свалка отмечена на карте как перечеркнутый, красный круг.
:?:.сто::Степень износа определенных деталей автомобиля можно узнать на автомастерской (иконка гаечного ключа с отверткой на карте).
:?:.дон::Задонатить можно на нашем официальном сайте - majestic-rp.ru/donate
:?:.оружрын::Боту на рынке можно сдать оружие только со 100% износом.
:?:.банк::У нас на сервере есть 3 вида банковских карт: Standart, Premium, VIP. Standart карта стоит в обслуживании 500$ в месяц, снятия и переводы без комиссии до 500.000$ после превышения месечного лимита комиссия на вывод 5%(Максимум 20.000$), на перевод 4%(Максимум 20.000$), кэшбек в магазинах отсутствует. Premium карта стоит в обслуживании 25.000$ в месяц, снятия и переводы без комиссии до 2.500.000$ после превышения месечного лимита комиссия на вывод 4%(Максимум 15.000$), на перевод 3%(Максимум 15.000$), кэшбек в магазинах 1%, лимит кэшбека на одну операцию до 2.500$, месечный лимит кэшбека 50.000$. VIP карта стоит в обслуживании 75.000$ в месяц, снятия и переводы без комиссии до 20.000.000$ после превышения месечного лимита комиссия на вывод 3%(Максимум 20.000$), на перевод 2.5%(Максимум 20.000$), кэшбек в магазинах 3%, лимит кэшбека на одну операцию до 10.000$, месечный лимит кэшбека 150.000$. Деньги за обслуживание и лимиты снимаются каждое 1 число нового месяца.
:?:.дублик::Чтобы сделать дубликат ключей от авто необходимо купить заготовку в магазине 24/7, затем нажать G на авто и сделать дубликат.
:?:.клад::Чтобы сделать дубликат от кладовки, необходимо купить заготовку в магазине 24/7, затем через G на игрока "сделать ключ от кладовки" и передать дубликат человеку.
:?:.подсел::Чтобы подселить игрока к себе в дом или же квартиру, стоя около дома, наведитесь на игрока и нажмите G, далее нажмите Подселить.
:?:.замок::Вам необходимо купить "Дверной замок" и "Набор инструментов" на ближайшей заправке, затем подойти к своему транспорту G -> Починить/заменить дверной замок.
:?:.акум::Вам необходимо купить "Аккумулятор" и "Набор инструментов" на ближайшей заправке, затем подойти к своему транспорту G -> Заменить аккумулятор.
:?:.масло::Вам необходимо купить "Моторное масло" и "Набор инструментов" на ближайшей заправке, затем подойти к своему транспорту G -> Заменить масло.
:?:.канистра::Что бы заправить т/c с помощью канистры, вам нужно взять ее в активный слот, нажать G по транспорту. Увидите там кнопку заправить транспорт.
:?:.рем::Чтобы починить своё авто купите рем.комплект на любой АЗС. Через меню G почините Ваш автомобиль.
:?:.госдом::Чтобы продать дом в гос. стоимость, нужно подойти к двери и нажать Е. Вы получите 75% от его гос. цены. Если Вы невовремя оплатите налоги или забудете это сделать, дом слетит автоматически.
:?:.рыблиц::Получить лицензию на рыбалку вы можете в Мэрии. 
:?:.кости::Чтобы играть в кости вам нужно купить их в любом 24/7. После того как вы купили кости, вы можете подойти к игроку.
:?:.толк::Транспорт можно толкать, нажав G-толкать. Если такой функции нет, при наведении на авто, то этот транспорт толкать нельзя.
:?:.счет::Чтобы узнать номер счета откройте инвентарь и наведитесь мышкой на банковскую карту. 
:?:.пин::Чтобы восстановить пин-код отправляйтесь в банковское отделение, в меню нажмите "Сменить пинкод".
:?:.дрифт::Вам необходимо включить дрифт счётчик через F2 - Настройки - дополнительное. Он появляется во время управляемого заноса и показывает, ваши дрифт очки, чтобы очки засчитывали в задание пропуска нужно набрать более 2.500 поинтов. После кого как вы набрали очки вам необходимо остановиться чтобы они засчитались, главное не врезаться и не перекручивать поворот, иначе очки сбросятся. Дрифт зона отмечена на карте как иконка горящего колеса, пример - одна из зон около LS Vagos.
:?:.скин::Скин появляется в донат инвентаре, его можно будет распылить. Однако при его применении невозможно дальнейшее распыление. Чтобы применить скин: F2 - Магазин - Cкины - Выбираете оружие/бронежилет и скин к нему - Применить, скин применяется ко всем оружиям/бронежилетам выбранного типа. Скин привязывается к игроку, выбить оружие со скином/сбросить/обменять/продать - невозможно.
:?:.стрим::Режим стримера заменяет символы на звездочки, для обычных игроков он бесполезен. Выключается в F2 - Настройки.
:?:.парашут::Положите парашют в быстрый слот, затем в полете нажмите на 1, 2 или 3 (зависит от слота), после этого ЛКМ, парашют откроется.
:?:.походка::Изменить походу и эмоции лица можно в  F2 - Настройки - Главное.
:?:.багаж::Чтобы вылезти из багажника нажмите на "E", багажник должен быть открытым.
:?:.нал::Чтобы оплатить налоги на дом необходимо открыть приложение "Мой дом" в планшете.
:?:.дил::Диллеры проходят два раза в день, в 10:45 и 18:45.
:?:.цех::Захват цехов проводит два раза в день, в 14:45 и 22:45.
:?:.вес::Проверьте возможно вы просто перегружены, Вес отображается в правом верхнем углу инвентаря, он не должен привышать 30 кг.
:?:.ключ::Вам нужно приехать на ключ и вызвать там своей автомобиль нажав E на синей метке. (Ключ - гаечный ключ на карте, называется автосервис)
:?:.дмк::Дефибриллятор МК2 никакого функционала не даёт, он аналогичен обычному дефибриллятору.
:?:.арм::Сыграть в платный армрестлинг Вы можете напротив банды The Families в гетто либо же напротив Шерифского департамента в Палето-Бей.

:?:.вынос::Выносливость - навык выносливости повышается от подвижного образа жизни. Чем больше ты бегаешь, тем быстрее повышается навык. При низком навыке, персонаж не может прыгнуть 2 раза и падает. Соответственно повышение навыка влияет на длительность беспрерывного бега и количество прыжков, максимум на последнем уровне - 2.
:?:.сила::Сила - навык силы повышается от физических нагрузок. Чем больше ты занимаешься в качалке (иконка гантели), тем быстрее повышается навык. От прокачки увеличивается сопротивление к урону от падения.
:?:.дых::Дыхание - навык дыхания повышается от длительного нахождения под водой. Чем больше ты плаваешь, тем быстрее повышается навык. Соответственно повышение навыка влияет на длительность беспрерывного плавания под водой.
:?:.вожден::Вождение - навык вождения повышается от времени, проведенного за рулем автомобиля. Чем больше ты водишь транспорт, тем быстрее повышается навык. От прокачки увеличивается управляемость транспортным средоством.
:?:.полет::Полет - навык пилотирования повышается от времени, проведенного за воздушным транспортом. Чем больше ты летаешь на самолете или вертолете, тем быстрее повышается навык. Также навык можно повысив пройдя курсы в летной школе. Пройти их можно 1 раз в 24 часа, увелчение навыка от 1 занятия - 10, стоимость одного занятия - 2 000$. От прокачки навыка увеличивается стабильность полета и управляемость воздушным транспортом.
:?:.скрытн::Скрытность - навык скрытности повышается от количества успешных уходов от погони (понижений уровня розыска). Чем чаще ты скрываешься от полиции, тем быстрее повышается навык. Ни на что на влияет
:?:.стрельба::Стрельба - навык стрельбы повышается от времени, проведенного в перестрелках, либо тренировках. Чем лучше ты стреляешь и попадаешь, тем быстрее повышается навык. Рекомендуем тренироваться в специально отведенных для того местах, тире в оружейном магазине. От прокачки навыка увеличивается скорость перезарядки и перекатов, кучность стрельбы.

:?:.камера::Информацию о механике поломки камеры вы можете найти тут https://wiki.majestic-rp.ru/post/unichtozhenie-kamer
:?:.маркет::Информацию о механике маркетплейса вы можете найти тут https://wiki.majestic-rp.ru/post/marketplejs
:?:.даль::Информацию о работе дальнобойщика вы можете найти тут https://wiki.majestic-rp.ru/post/dalnobojshik
:?:.рыбак::Информацию о механике рыбалки вы можете найти тут https://wiki.majestic-rp.ru/post/rybak
:?:.гриб::Информацию о работе грибника вы можете найти тут https://wiki.majestic-rp.ru/post/gribnik
:?:.работы::Информацию о работах на проекте вы можете найти тут https://wiki.majestic-rp.ru
:?:.метал::Металлоискатель становится активным как только Вы берете его в руки. Когда он найдет сокровища, то будут происходить визуальные и звуковые оповещения. От зеленого цвета, до красного. Места расположения сокровищ: пляжи и архипелаги.
:?:.работа::На сервере есть квесты на работах у НПС, такие как Шахта/Рыбалка/Лесоруб/Дальнобойщик/Мусоровоз, Вам нужно взять квесть у них. У бота на работе будет кнопка "Я могу чем-то помочь". Вы на неё жмёте и у вас откроется квест, который выполнить нужно (на Ф6 можно посмотреть). Выполняете этот квест и Вам засчитывает задание.
:?:.груп::Чтобы вместе работать на кооперативной работе вам необходимо пригались игроков через приложение "Группа" в телефоне.

;TR Ответы
:?:/ljkuj::Вы долго не отвечали, закрываю репорт.
:?:/ytdbl::Не видя полной ситуации, не могу выдать наказание игроку.
:?:/frnefk::Приносим извинения за столь долгое ожидание. Пожалуйста, если проблема еще актуальна, продублируйте её в своем обращении. Спасибо за понимание.
:?:/bvz::Напишите именной репорт на имя администратора, который выдал вам наказание.
:?:/vu::Могу еще чем то вам помочь ?
:?:/ptqltq::PayDay приходить каждый час и начисляет зарплату во фракции, если же вы не состоите во фракции, вам будет начисляться пособие по безработице.
:?:/eujy::Для угона транспортного средства, вам необходимо турбо декодер и программатор ЭБУ.
:?:/g::Приятной игры и хорошего настроения.
:?:/afv::/c - IC чат, /cb - OOC чат. 
:?:/ahfr::/f - IC чат, /fb - OOC чат.

;Ивенты

;Прятки
:?:.прятки::
SetKeyDelay, 5, 5
SendMessage, 0x50,, 0x4090409
Send, /tp id+`n
Sleep 300
Send, /eventon+`n
Sleep 300
Send, /gw id weapon_heavysniper_mk2 9999+`n
Sleep 300
Send, /gw id weapon_heavysniper_mk2 9999+`n
Sleep 300
Send, /gw id weapon_heavysniper_mk2 9999+`n
Sleep 300
Send, /o Уважаемые игроки, сейчас будет проведено мероприятие под названием "Прятки", призовой фонд которого составляет 50.000$. Если вы хотите принять в нем участие, введите команду /event. Напомню что уход от РП, путём ухода на ивент - строго запрещён{!}+`n
Sleep 300
Send, /eventoff
return

;Дерби
:?:.дерби::
SetKeyDelay, 5, 5
SendMessage, 0x50,, 0x4090409
Send, /tp id+`n
Sleep 300
Send, /eventon+`n
Sleep 300
Send, /veh matiz (30)+`n
Sleep 300
Send, /veh phantom2 (5)+`n
Sleep 300
Send, /gw id weapon_rpg 9999+`n
Sleep 300
Send, /o Уважаемые игроки, сейчас будет проведено мероприятие под названием "Дерби", призовой фонд которого составляет 50.000$. Если вы хотите принять в нем участие, введите команду /event. Напомню что уход от РП, путём ухода на ивент - строго запрещён{!}+`n
Sleep 300
Send, /eventoff
return

;Вышибалы
:?:.вышибалы::
SetKeyDelay, 5, 5
SendMessage, 0x50,, 0x4090409
Send, /tp id+`n
Sleep 300
Send, /eventon+`n
Sleep 300
Send, /veh bdivo 3+`n
Sleep 300
Send, /gw id weapon_rpg 9999+`n
Sleep 300
Send, /o Уважаемые игроки, сейчас будет проведено мероприятие под названием "Вышибалы", призовой фонд которого составляет 50.000$. Если вы хотите принять в нем участие, введите команду /event. Напомню что уход от РП, путём ухода на ивент - строго запрещён{!}+`n
Sleep 300
Send, /eventoff
return

;Анекдоты
:?:.анекдоты::
SetKeyDelay, 5, 5
SendMessage, 0x50,, 0x4090409
Send, /tp id+`n
Sleep 300
Send, /eventon+`n
Sleep 300
Send, /gw id weapon_heavysniper_mk2 99999+`n
Sleep 300
Send, /gw id weapon_heavysniper_mk2 99999+`n
Sleep 300
Send, /o Уважаемые игроки, сейчас будет проведено мероприятие под названием "Конкурс анекдотов", призовой фонд которого составляет 50.000$. Если вы хотите принять в нем участие, введите команду /event. Напомню что уход от РП, путём ухода на ивент - строго запрещён{!}+`n
Sleep 300
Send, /eventoff
return

;Экстрасенсы
:?:.экстрасенсы::
SetKeyDelay, 5, 5
SendMessage, 0x50,, 0x4090409
Send, /tp id+`n
Sleep 300
Send, /eventon+`n
Sleep 300
Send, /gw id weapon_firework 9999+`n
Sleep 300
Send, /gw id weapon_firework 9999+`n
Sleep 300
Send, /veh vaz2109+`n
Sleep 300
Send, /veh tr3+`n
Sleep 300
Send, /veh speedo2+`n
Sleep 300
Send, /veh dominator6+`n
Sleep 300
Send, /veh ztype+`n
Sleep 300
Send, /o Уважаемые игроки, сейчас будет проведено мероприятие под названием "Битва Экстрасенсов", призовой фонд которого составляет 50.000$. Если вы хотите принять в нем участие, введите команду /event. Напомню что уход от РП, путём ухода на ивент - строго запрещён{!}+`n
Sleep 300
Send, /eventoff
return

; Наказания
:?:.фофошд::/ajail
:?:/ajajil::/ajail
:?:.фофшд::/ajail
:?:.гтофшд::/unjail
;пго
:?:.пго::/ajail  35 1.18ПГО{Left 11}
; NRD
:?:.нрд::/ajail 15 NRD{Left 7}
:?:.нрд30::/ajail 30 NRD{Left 7}
:?:.нрд45::/ajail 45 NRD{Left 7}
:?:.нрд60::/ajail 60 NRD{Left 7}
:?:.нрд90::/ajail 90 NRD{Left 7}
; Nrp
:?:.нрп::/ajail 15 nonRP Поведение{Left 19}
:?:.нрп30::/ajail 30 nonRP Поведение{Left 19}
:?:.нрп45::/ajail 45 nonRP Поведение{Left 19}
:?:.нрп60::/ajail 60 nonRP Поведение{Left 19}
:?:.нрп90::/ajail 90 nonRP Поведение{Left 19}
:?:.нрпп::/ajail 15 nonRP Проникновение{Left 23}
; DB
:?:.дб::/ajail 30 DB{Left 6}
:?:.дб45::/ajail 45 DB{Left 6}
:?:.дб60::/ajail 60 DB{Left 6}
:?:.дб75::/ajail 75 DB{Left 6}
:?:.дб90::/ajail 90 DB{Left 6}
; DM
:?:.дм::/gunban 5 DM{Left 5}
:?:.дм120::/ajail  120 DM{Left 7}
; PG
:?:.пг::/ajail 35 PG{Left 6}
:?:.пг60::/ajail 60 PG{Left 6}
:?:.пг75::/ajail 75 PG{Left 6}
:?:.пг90::/ajail 90 PG{Left 6}
; OOC
:?:.оск::/ajail 15 OOC Оскорбление.{Left 20}
:?:.ooc::/mute 90 OOC in IC.{Left 14}
; SP
:?:.сп::/mute 30 SP in GZ{Left 12}
:?:.ис::/mute 90 OOC in IC{Left 13}
:?:.сп60::/mute 60 SP in GZ{Left 12}
:?:.тон::/mute 30 ПО для изменения тональности голоса.{Left 40}
; ВЗА
:?:.вза18::/ajail 35 1.8 ВЗА{Left 11}
:?:.вза19::/ajail 45 1.9 ВЗА{Left 11}
:?:.вза31::/ajail 90 3.1 ВЗА{Left 11}
:?:.вза35::/ajail 35 3.5 ВЗА{Left 11}
; ППП
:?:.ппп16::/ajail 90 1.6 ППП{Left 11}
; Ник внешка
:?:.ник::/ajail 720 До смены имени/фамилии{Left 27}
:?:.пол::/ajail 720 Смените внешность согласно правилам сервера{Left 48}
; Crime zz
:?:.кзз::/ajail 15 Crime in GZ{Left 15}
; Разное
:?:.читс::/hardban 9999 Cheat{Left 11}
:?:.уход::/warn Уход от RP{Left 11}
:?:.уходб::/ban 4 Уход от RP{Left 12}

:?:.снег::
SendMessage, 0x50,, 0x4190419,, A
sleep 200
Sendinput, /setweatherlocal extrasunny{enter}
sleep 600
Sendinput, {t}
sleep 200
Sendinput, /togglesnow 0{enter}
return

Reload:
reload
return

^F9::reload
^F10::Exitapp

:?:.ку::
SendMessage, 0x50,, 0x4190419,, A
SendInput, Приветствую, сейчас я займусь Вашим обращением. Ожидайте.
SendInput, {Enter}
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
Return

:?:/re::
SendMessage, 0x50,, 0x4190419,, A
SendInput, Приветствую, сейчас я займусь Вашим обращением. Ожидайте.
SendInput, {Enter}
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
Return


UpdateGender:
    IniRead, Radio1, %A_ScriptDir%\ahk\Settings.ini, gender, gender1
    IniRead, Radio2, %A_ScriptDir%\ahk\Settings.ini, gender, gender2

    if (Radio1 = "1") {
        gender := ""
    } else if (Radio2 = "1") {
        gender := "а"
    } else {
        gender := ""
    }
return

:?:.н::
    Gosub, UpdateGender  ; вызов программы гендер
    SendMessage, 0x50,, 0x4190419,, A
    SendInput,Выдал%gender% наказание игроку.
return

:?:/y::
    Gosub, UpdateGender  ; вызов программы гендер
    SendMessage, 0x50,, 0x4190419,, A
    SendInput,Выдал%gender% наказание игроку.
return

:?:.пред::
    Gosub, UpdateGender  ; вызов программы гендер
    SendMessage, 0x50,, 0x4190419,, A
    SendInput,Прудепредил%gender% Игрока о нарушении.
return

:?:/ghtl::
    Gosub, UpdateGender  ; вызов программы гендер
    SendMessage, 0x50,, 0x4190419,, A
    SendInput,Прудепредил%gender% Игрока о нарушении.
return

:?:/ytg::
    Gosub, UpdateGender  ; вызов программы гендер
    SendMessage, 0x50,, 0x4190419,, A
    SendInput,Не понял%gender% суть вашего обращения, опишите Вашу проблему/вопрос подробнее для максимально точного ответа, пожалуйста.
return

:?:.неп::
    Gosub, UpdateGender  ; вызов программы гендер
    SendMessage, 0x50,, 0x4190419,, A
    SendInput,Не понял%gender% суть вашего обращения, опишите Вашу проблему/вопрос подробнее для максимально точного ответа, пожалуйста.
return

:?:.неув::
    Gosub, UpdateGender  ; вызов программы гендер
    SendMessage, 0x50,, 0x4190419,, A
    SendInput,Не увидел%gender% нарушений, если у вас есть видео-доказательства - оставьте жалобу на форуме. 
return

:?:/yted::
    Gosub, UpdateGender  ; вызов программы гендер
    SendMessage, 0x50,, 0x4190419,, A
    SendInput,Не увидел%gender% нарушений, если у вас есть видео-доказательства - оставьте жалобу на форуме. 
return

Close:
exitapp

Hide:
Gui, Main: Hide
return

Show:
Gui, Main: Show
return

guiclose2:
gui, Main:hide

guiclose:
Gui, Answers:Destroy
return

guiclose3:
Gui, Commandlist:Destroy
return

guiclose4:
Gui, Usefull:Destroy
return

MainGuiClose:
GuiEscape:
ExitApp
