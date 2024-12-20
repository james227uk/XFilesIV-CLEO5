        �  �
vM �����  9    M ����   �   �  ����                      �  � ��  9   M �����
����  �   �  	 �
rotateCamera@MathUtils.s     	   	  �  �
WM �����
moveCamera@MathUtils.s     	   �?         	  �  �
SM e����
moveCamera@MathUtils.s     	   ��         	  �  �
AM ����
moveCamera@MathUtils.s     	       ��     	  �  �
DM �����
moveCamera@MathUtils.s     	       �?     	  _      `  	 �  =qM �����  �
cameraCoordinates.txtat M �����
 A//----------------------------------------------------------// %c
 �
 QCamera.SetFixedPosition({Pos3:}%0.4f, %0.4f, %0.4f, {Rot. Pos3:}0.0, 0.0, 0.0) %c   
 �
 FCamera.PointAtPoint({Pos3:}%0.4f, %0.4f, %0.4f, SwitchType.Jumpcut) %c  	 
 �
 A//----------------------------------------------------------// %c
 �
 �
Camera coordinates saved! �����
�� �	D   C  C  �B   � I?���>fff?C  D& ��C  �BIUse ~y~W,A,S,D~w~ to move the camera and ~g~F2~w~ to save the coordinates �    �   I?�Ga>��Q?C �D& ��C  C&Camera Coords: X:%0.4f Y:%0.4f Z:%0.4f     I?�Ga>��Q?C �D& ��C  6C'PointAt Coords: X:%0.4f Y:%0.4f Z:%0.4f    � �
  FLAG   SRC �  {$CLEO .cs}
{$USE CLEO+}

import rotateCamera from "MathUtils.s"
import moveCamera from "MathUtils.s"

nop


int isCameraActive = FALSE
float cameraX, cameraY, cameraZ
float rotationX, rotationY, rotationZ
float pointAtX, pointAtY, pointAtZ
float mouseDeltaX, mouseDeltaY



WHILE TRUE
    WAIT 0
    
    IF Pad.IsKeyPressed(KeyCode.F7)
    THEN
        IF isCameraActive == FALSE
        THEN
            isCameraActive = TRUE
            Player.setControl($player1, FALSE)
            wait 200
        ELSE
            isCameraActive = FALSE
            rotationX = 0.0
            rotationY = 0.0
            rotationZ = 0.0
            Player.setControl($player1, TRUE)
            wait 200
            Camera.RestoreJumpcut()
        END
    END

    IF isCameraActive == TRUE
    THEN
        drawCameraHelperBox()
        cameraX, cameraY, cameraZ = Camera.GetActiveCoordinates()
        pointAtX, pointAtY, pointAtZ = Camera.GetActivePointAt()
        
        pointAtX, pointAtY, pointAtZ = rotateCamera(cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ)
        
        
        IF Pad.IsKeyPressed(KeyCode.W)
        THEN
            cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ = moveCamera(cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ, 1.0, 0.0)
        END
        
        IF Pad.IsKeyPressed(KeyCode.S)
        THEN
            cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ = moveCamera(cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ, -1.0, 0.0)
        END
        
        IF Pad.IsKeyPressed(KeyCode.A)
        THEN
            cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ = moveCamera(cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ, 0.0, -1.0)
        END
        
        IF Pad.IsKeyPressed(KeyCode.D)
        THEN
            cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ = moveCamera(cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ, 0.0, 1.0)
        END
        
        Camera.SetFixedPosition(cameraX, cameraY, cameraZ, rotationX, rotationY, rotationZ)
        Camera.PointAtPoint(pointAtX, pointAtY, pointAtZ, SwitchType.JumpCut)
        
        IF Pad.IsKeyJustPressed(KeyCode.F2)
        THEN
            IF File cameraCoordinates = File.Open("cameraCoordinates.txt", "at")
            THEN
                cameraCoordinates.WriteFormattedString("//----------------------------------------------------------// %c", 0xA)
                //writeLocalTimeToFile(cameraCoordinates)
                cameraCoordinates.WriteFormattedString("Camera.SetFixedPosition({Pos3:}%0.4f, %0.4f, %0.4f, {Rot. Pos3:}0.0, 0.0, 0.0) %c", cameraX, cameraY, cameraZ, 0xA)
                cameraCoordinates.WriteFormattedString("Camera.PointAtPoint({Pos3:}%0.4f, %0.4f, %0.4f, SwitchType.Jumpcut) %c", pointAtX, pointAtY, pointAtZ, 0xA)
                cameraCoordinates.WriteFormattedString("//----------------------------------------------------------// %c", 0xA)
                cameraCoordinates.Close()
                Text.PrintHelpString("Camera coordinates saved!")
            END
        END
        
    END
     
END


:TERMINATE
terminate_this_custom_script

//function writeLocalTimeToFile(fileToWriteTo: File)

//    int year, month, weekDay, day, hour, minute, second, milisecond
//    year, month, weekDay, day, hour, minute, second, milisecond = Clock.GetLocalTime()
//    fileToWriteTo.WriteFormattedString("//-----------Time: %d.%d.%d: %d:%d:%d---------// %c", day, month, year, hour, minute, second, 0xA)

//end

function drawCameraHelperBox()
    Text.UseCommands(true)
    Hud.DrawRect(550.0, 160.0, 140.0, 120.0, 0,0,0, 200)
    Text.SetFont(Font.Menu)
    Text.SetScale(0.3, 0.9)
    Text.SetWrapX(620.0)
    Text.DisplayFormatted(485.0, 105.0, "Use ~y~W,A,S,D~w~ to move the camera and ~g~F2~w~ to save the coordinates")
    
    float cameraX, cameraY, cameraZ, pointAtX, pointAtY, pointAtZ
    cameraX, cameraY, cameraZ = Camera.GetActiveCoordinates()
    pointAtX, pointAtY, pointAtZ = Camera.GetActivePointAt()
    
    Text.SetFont(Font.Menu)
    Text.SetScale(0.22, 0.82)
    Text.SetWrapX(570.0)
    Text.DisplayFormatted(485.0, 147.0, "Camera Coords: X:%0.4f Y:%0.4f Z:%0.4f", cameraX, cameraY, cameraZ)
    
    Text.SetFont(Font.Menu)
    Text.SetScale(0.22, 0.82)
    Text.SetWrapX(570.0)
    Text.DisplayFormatted(485.0, 182.0, "PointAt Coords: X:%0.4f Y:%0.4f Z:%0.4f", pointAtX, pointAtY, pointAtZ)
    
    Text.UseCommands(false)
end�  __SBFTR 