object dmDataBase: TdmDataBase
  OldCreateOrder = False
  Height = 118
  Width = 126
  object FDConexao: TFDConnection
    Params.Strings = (
      'Database=farmacia'
      'User_Name=farmacia'
      'Password=123456'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 24
  end
end
