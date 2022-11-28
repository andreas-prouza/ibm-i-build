     H nomain

      /include 'qcpysrc/errhdlrpg'

      //------------------------------------------------------------------------
      // Retrieves last message
      //------------------------------------------------------------------------
     P catch           B                   Export
     D                 PI
      // Procedure Interface
     D CaughtMessage                       LikeDS(Base_CaughtMessage)
     D P_StackCount                        Like(T_StackCount)
     D                                     Const Options(*NoPass)

      // local Variables
     D MsgBack         DS                  LikeDs(RCVM0300) Inz
     D SetMsgKey       S              4    Inz(*BLANK)
     D L_StackCount    S                   Like(T_StackCount)
     D                                     Inz(1)

      /Free
         Clear CaughtMessage;
         Clear APIError;

         if (%Parms >= %Parmnum(P_StackCount) And P_StackCount > 0);
           L_StackCount = P_StackCount;
         ENDIF;

         ReceiveMsg( MsgBack
                   : %Size(MsgBack)
                   : 'RCVM0300'
                   : '*'
                   : L_StackCount
                   : '*LAST'
                   : SetMsgKey
                   : 0
                   : '*SAME'
                   : APIError);

         If MsgBack.ByteAvail > 0;

           CaughtMessage.MsgId = MsgBack.MsgId;
           CaughtMessage.MsgFileName = MsgBack.MsgFileName;
           CaughtMessage.MsgLibName = MsgBack.MsgLibUsed;
           CaughtMessage.MsgText =
                    %SubSt(MsgBack.MsgData:
                           MsgBack.LenReplace1 + 1:
                           MsgBack.LenMsgReturn);

           If MsgBack.LenReplace1 > 0;
             CaughtMessage.MsgData =
             %SubSt(MsgBack.MsgData: 1: MsgBack.LenReplace1);
           EndIf;
         EndIf;
      /End-Free

     P                 E

