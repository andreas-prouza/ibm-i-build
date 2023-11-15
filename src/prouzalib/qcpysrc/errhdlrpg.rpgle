
     D CaughtMessagePtr...
     D                 S               *

     D DummyPtr        S               *

     D RCVM0300Ptr     S               *

     D RCVM0200Ptr     S               *

      *** Message
     D T_CMessage      S           1024    Template
     D T_CMessage2     S           3000    Template
     D T_CMessageData  S           3000    Template
     D T_MessageID     S              7    Template
     D T_MsgVarNumber  S             10I 0 Template
     D T_MsgVarType    S              6    Template
     D T_MsgVarLen     S             10I 0 Template
     D T_MsgVarInt2Char...
     D                 S              5    Template
     D T_StackCount    S             10I 0 Template

     D Base_CaughtMessage...
     D                 DS                  BASED(CaughtMessagePtr)
     D                                     Qualified
     D MsgId                          7A
     D MsgFile                       20A
     D MsgFileName                   10A   OverLay(MsgFile)
     D MsgLibName                    10A   OverLay(MsgFile:*Next)
     D MsgText                             Like (T_CMessage)
     D Msgdata                             Like (T_CMessageData)
     D MsgText2                            Like (T_CMessage2)
     D CountErrors                   10I 0

      ** API Error DS

     D APIError        DS                  Qualified
     D BytesProvided                 10I 0 inz(%size(APIError))
     D BytesAvail                    10I 0 inz(0)
     D MsgId                          7A
     D                                1A
     D MsgData                      240A


     D RCVM0300        DS                  Qualified Based(RCVM0300Ptr)
     D ByteReturned                  10I 0
     D ByteAvail                     10I 0
     D MsgSeverity                   10I 0
     D MsgId                          7A
     D MsgType                        2A
     D MsgKey                         4A
     D MsgFileName                   10A
     D MsgLibSpec                    10A
     D MsgLibUsed                    10A
     D AlertOption                    9A
     D CCSIDCnvIndText...
     D                               10I 0
     D CCSIDCnvIndData...
     D                               10I 0
     D CCSIDMsg                      10I 0
     D CCSIDReplace                  10I 0
     D LenReplace1                   10I 0
     D LenReplace2                   10I 0
     D LenMsgReturn                  10I 0
     D LenMsgAvail                   10I 0
     D LenHelpReturn                 10I 0
     D LenHelpAvail                  10I 0
     D LenSenderReturn...
     D                               10I 0
     D LenSenderAvail...
     D                               10I 0
     D MsgData                     5000A


     D RCVM0200        DS                  Qualified Based(RCVM0200Ptr)
     D ByteReturned                  10I 0
     D ByteAvail                     10I 0
     D MsgSeverity                   10I 0
     D MsgId                          7A
     D MsgType                        2A
     D MsgKey                         4A
     D MsgFileName                   10A
     D MsgLibSpec                    10A
     D MsgLibUsed                    10A
     D SendingJob                    10A
     D SendingJobUserProfile...
     D                               10A
     D SendingJobNr                   6A
     D SendingProgramName...
     D                               12A
     D SndInstructNr                  4A
     D DateSent                       7A
     D TimeSent                       6A
     D RcvProgramName                10A
     D RcvInstructNr                  4A
     D SendingType                    1A
     D ReceivingType                  1A
     D Reserved                       1A
     D CCSIDCnvIndText...
     D                               10I 0
     D CCSIDCnvIndData...
     D                               10I 0
     D AlertOption                    9A
     D CCSIDMsg                      10I 0
     D CCSIDReplace                  10I 0
     D LenReplace1                   10I 0
     D LenReplace2                   10I 0
     D LenMsgReturn                  10I 0
     D LenMsgAvail                   10I 0
     D LenHelpReturn                 10I 0
     D LenHelpAvail                  10I 0
     D MsgData                     5000A


      // Message fangen
     D catch           PR
     D CaughtMessage                       LikeDS(Base_CaughtMessage)
     D P_StackCount                        Like(T_StackCount)
     D                                     Const Options(*NoPass)


      // Receieve Message from Program Message Queue
     D ReceiveMsg      PR                  ExtPgm('QMHRCVPM')
     D MsgInfo                     3000    Options(*VarSize)
     D MsgInfoLen                    10I 0 Const
     D FormatName                     8    Const
     D CallStack                     10    Const
     D CallStackCtr                  10I 0 Const
     D MsgType                       10    Const
     D MsgKey                         4    Const
     D WaitTime                      10I 0 Const
     D MsgAction                     10    Const
     D ErrorForAPI                         Like(APIError)


