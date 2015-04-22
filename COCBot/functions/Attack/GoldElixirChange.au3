;==========================================================================
; Function name: GoldElixirChange
; Authored by:
; Edited by: Samota,
;
; Description: Checks if the gold/elixir changes values within 20 seconds, Returns True if changed. Also
; checks every 5 seconds if gold/elixir = "", meaning battle is over. If either condition is met, return
; false.
; Now also check Dark Elixir
;
; Notes: If all troops are used, the battle will end when they are all dead, the timer runs out, or the
; base has been 3-starred. When the battle ends, it is detected within 5 seconds, otherwise it takes up
; to 20 seconds.
;
;==========================================================================
Func GoldElixirChange()
	Local $Gold1, $Gold2
	Local $GoldChange, $ElixirChange, $DarkChange
	Local $Elixir1, $Elixir2
	Local $Dark1, $Dark2
	While 1
		If _Sleep(3000) Then Return
		$Gold1 = getGold(51, 66)
		$Elixir1 = getElixir(51, 66 + 29)
;		If $searchDark <> 0 Then
;				$Dark1 = getDarkElixir(51, 66 + 57)
;		Else
;			$Dark1 = 0
;		EndIf
		$Dark1 = ($searchDark <> 0 ) ? getDarkElixir(51, 66 + 57) : 0
		;		Local $iBegin = TimerInit(), $x = 10000
		;		While TimerDiff($iBegin) < $x
		If _Sleep(7000) Then Return
		SetLog("Checking if the battle has finished", $COLOR_GREEN)
		$Gold2 = getGold(51, 66)
		$Elixir2 = getElixir(51, 66 + 29)
		If $Gold2 <> "" Or $Elixir2 <> "" Then
			$GoldChange = $Gold2
			$ElixirChange = $Elixir2
			$Dark2 = ($searchDark <> 0 ) ? getDarkElixir(51, 66 + 57) : 0
;			If $searchDark <> 0 Then
;				$Dark2 = getDarkElixir(51, 66 + 57)
;			Else
;				$Dark2 = 0
;			EndIf
		EndIf
		If ($Gold2 = "" And $Elixir2 = "") Then
			SetLog("Battle has finished", $COLOR_GREEN)
			Return False
		ElseIf ($Gold2 = 0 And $Elixir2 = 0) Then
			SetLog("No resource detected, returning in " & $itxtReturnh & " seconds", $COLOR_GREEN)
			If _Sleep($itxtReturnh * 1000) Then Return
			GUICtrlSetData($lblresultvillagesattacked, GUICtrlRead($lblresultvillagesattacked) + 1)
			Return False
		ElseIf ($Gold1 = $Gold2 And $Elixir1 = $Elixir2 and $Dark1 = $Dark2 ) Then
			SetLog("No Income detected, returning in " & $itxtReturnh & " seconds", $COLOR_BLUE)
			If _Sleep($itxtReturnh * 1000) Then Return
			GUICtrlSetData($lblresultvillagesattacked, GUICtrlRead($lblresultvillagesattacked) + 1)
			Return False
		Else
			SetLog("Loot change detected, waiting...", $COLOR_GREEN)
			Return True
		EndIf
		ExitLoop
	WEnd
EndFunc   ;==>GoldElixirChange