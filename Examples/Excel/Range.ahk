; Note: There is usually no need to Activate/Select a range in order to get or set the value.
; Activate/Select is done here for demonstration only -- it demonstrates that a reference to a range has been retrieved.
; See 'Copy a range' below for how to copy ranges.

xlApp := ComObjActive("Excel.Application")  ; Excel must be running.


; Application.Range
MyRange := xlApp.Range("C2")  ; Get a range object representing cell C2.
MyRange.Select
MsgBox, % "The cell " MyRange.Address " should be selected."

MyRange := xlApp.Range("C2:D5")  ; Get a range object representing cells C2 to D5.
MyRange.Select
MsgBox, % "The range " MyRange.Address " should be selected. This range contains " MyRange.Rows.Count
        . " rows and " MyRange.Columns.Count " columns."

; Same as the above line, except this uses cell references instead of a string.
; ie: xlApp.Range(TopLeftCell, BotRightCell)
;   TopLeftCell - an AHK variable containing a reference to a cell.
;   BotRightCell - an AHK variable containing a reference to a cell.
MyRange := xlApp.Range(xlApp.Range("C2"), xlApp.Range("E6"))  ; Get a range object representing cells C2 to E6.
MyRange.Select
MsgBox, % "The range " MyRange.Address " should be selected. This range contains " MyRange.Rows.Count
        . " rows and " MyRange.Columns.Count " columns."

; Same as the above line, except this uses the 'Cells' method (instead of 'Range') to reference individual cells.
MyRange := xlApp.Range(xlApp.Cells(2, 3), xlApp.Cells(7, 6))  ; Get a range object representing cells C2 to F7.
MyRange.Select
MsgBox, % "The range " MyRange.Address " should be selected. This range contains " MyRange.Rows.Count
        . " rows and " MyRange.Columns.Count " columns."


; Worksheet.Range
MyRange := xlApp.Worksheets(2).Range("C2")  ; Get a range object representing cell C2 on the second worksheet.
xlApp.Worksheets(2).Activate  ; The sheet needs to be activated before a cell is selected.
MyRange.Select
MsgBox, % "The cell " MyRange.Address " should be selected on worksheet '" MyRange.Worksheet.Name "'."


; Copy a range
; Assign cell C2 to cell B1.
xlApp.Range("B1") := xlApp.Range("C2")
MsgBox, % "Cell B1 should now contain the same thing as cell C2."

; Assign cell C2 on Worksheet 2, to cell B1 on sheet 1.
; Unlike 'Select' above, the sheets do not need to be active.
xlApp.Worksheets(1).Range("B1") := xlApp.Worksheets(2).Range("C2")
MsgBox, % "Cell B1 on worksheet 1 should now contain the same thing as cell C2 on worksheet 2."

; The following lines will all use sheet 1, so we save a reference to that sheet in the variable 's'.
s := xlApp.Sheets(1)  ; Save a reference to sheet 1.

s.Range("A1").Value := s.Range("B1").Value   ; Copy the B1 value to A1.
s.Range("A2").Value := s.Range("B2").Value2  ; Copy the B2 value2 to A2.
s.Range("A3").Value := s.Range("B3").Text    ; Copy the B3 visible text to A3.

; Copy and paste
s.Range("B4").Copy                           ; Copy the B4 range.
s.Range("A4").PasteSpecial(xlPasteValues)    ; Paste a range from the clipboard into A4.
