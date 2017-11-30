object EntitysEditorForm: TEntitysEditorForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'EntitysEditorForm'
  ClientHeight = 255
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object paBottom: TPanel
    Left = 0
    Top = 219
    Width = 362
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object buCancel: TButton
      Left = 275
      Top = 5
      Width = 80
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object buOk: TButton
      Left = 190
      Top = 5
      Width = 80
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
  end
end
