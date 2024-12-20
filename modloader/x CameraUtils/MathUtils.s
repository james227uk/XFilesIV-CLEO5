 P�����  EXPT�   degreesToRadians ����    max !���    min P���    modulo ����    moveCamera H���    rotateCamera ���    �  %    M .����
   &����
   �
  �  %    M �����
    �����
  �
    �I@    4Ck    �
   �
  �    c   �    s   �   �   �   k   �
  �
  �    k   �   k   c   �    k   �   k   [   �
   �
       @J
  � 	  c 	   � 
  c 
  �   c   �       ��k   �       ��k   �
����   �
����   �  �  �
|���	 
   	 
  �
	    @ �

    @ �   [   �  �  �  �   k   �   k   c   �   k   �   k   [   �   �  C�     M �����   s   k 	  k 
  �    [  	 �   [  
 �   [   �
    �
  �   c    � 	  c 	  � 
  c 
  �
���� 	 
       [    [   [   �    [   �   [  	 �   [  
 �
        �
  �
����        �   � 	   	   �� 
     �
���� 	 
  	 
  k   k 	  k 
  �   k   [   �   k   [  	 �   k   [  
 �
����            ?     ?     ?�
    �
  �
     @ �
    @ �
    @ �   [   [   �  �  C�     M �����    s   � 	  s 	  � 
  s 
   ����       	      
     �
 	 
  �
  FLAG   SRC ^  {$CLEO .s}

export function min(x: float, y: float): float
    IF x > y
    THEN
        CLEO_RETURN 1 y
    ELSE
        CLEO_RETURN 1 x
    END
end

export function max(x: float, y: float): float
    IF x > y
    THEN
        CLEO_RETURN 1 x
    ELSE
        CLEO_RETURN 1 y
    END
end

export function degreesToRadians(degrees: float): float
    float multiply = 3.141592653589793
    multiply /= 180.0
    
    degrees *= multiply
    
    cleo_return 1 degrees

end

export function modulo(x:float, moduloValue: float): float
    float subtractedValue = x
    subtractedValue -= moduloValue
    
    
    float dividedValue = x
    dividedValue /= moduloValue
    int intDivisionResult =# dividedValue
    dividedValue =# intDivisionResult
    
    
    float localValue = subtractedValue
    localValue *= dividedValue
    
    cleo_return 1 localValue
end

function yawRotation(viewX: float, viewY: float, cosYawRad:float, sinYawRad: float):float, float
    //# Apply yaw rotation (around Z-axis)
    // temp_x = view_x * math.cos(yaw_radians) - view_y * math.sin(yaw_radians)
    float tempX = viewX
    tempX *= cosYawRad
    float tempX2 = viewY
    tempX2 *= sinYawRad
    tempX -= tempX2
    //-------------------------------------------------------------------------
    
    //temp_y = view_x * math.sin(yaw_radians) + view_y * math.cos(yaw_radians)
    float tempY = viewX 
    tempY *= sinYawRad
    float tempY2 = viewY
    tempY2 *= cosYawRad
    tempY += tempY2
    
    //-----------------------------------------------------------------------
    
    cleo_return 2 tempX, tempY

end


export function rotateCamera(cameraX: float, cameraY: float, cameraZ: float, lookAtX: float, lookAtY: float, lookAtZ: float): float, float, float
    float sensitivity = 2.0
    
    float mouseX, mouseY
    mouseX, mouseY = Mouse.GetMovement()
    
    float viewX = lookAtX
    viewX -= cameraX
    
    float viewY = lookAtY
    viewY -= cameraY
    
    float viewZ = lookAtZ
    viewZ -= cameraZ
    
    float yawAngle = mouseX
    yawAngle *= -1.0
    yawAngle *= sensitivity
    
    float pitchAngle = mouseY
    pitchAngle *= -1.0
    pitchAngle *= sensitivity
    
    float yawRadians = degreesToRadians(yawAngle)
    float pitchRadians = degreesToRadians(pitchAngle)
    
    float sinYawRad = Math.Sin(yawRadians)
    float cosYawRad = Math.Cos(yawRadians)
    
    viewX , viewY = yawRotation(viewX, viewY, cosYawRad, sinYawRad)

    // Calculate horizontal distance for pitch rotation
    // horizontal_distance = math.sqrt(view_x**2 + view_y**2)
    float sqrViewX = Math.Pow(viewX, 2.0)
    float sqrViewY = Math.Pow(viewY, 2.0)
      
    float horizontalDistance = sqrViewX
    horizontalDistance += sqrViewY
    
    horizontalDistance = Math.Sqrt(horizontalDistance)
    
    // # Apply pitch rotation (around X-axis)
    
    float sinPitchRad = Math.Sin(pitchRadians)
    float cosPitchRad = Math.Cos(pitchRadians)
    //temp_z = view_z * math.cos(pitch_radians) - horizontal_distance * math.sin(pitch_radians)
    float tempZ = viewZ
    tempZ *= cosPitchRad
    
    float tempZ2 = horizontalDistance
    tempZ2 *= sinPitchRad
    
    tempZ -= tempZ2
    
    //----------------------------------------------------------------------
    //temp_horizontal_distance = view_z * math.sin(pitch_radians) + horizontal_distance * math.cos(pitch_radians)
    
    float tempHorizontalDistance = viewZ
    tempHorizontalDistance *= sinPitchRad
    
    float tempHorizontalDistance2 = horizontalDistance
    tempHorizontalDistance2 *= cosPitchRad
    
    tempHorizontalDistance += tempHorizontalDistance2
    //view_z = temp_z
    
    viewZ = tempZ
    
    /**
    # Recalculate view_x and view_y based on new horizontal distance
    if horizontal_distance != 0:
        scale = temp_horizontal_distance / horizontal_distance
        view_x *= scale
        view_y *= scale
    */
    
    IF NOT horizontalDistance == 0.0
    THEN
        float scale = tempHorizontalDistance
        scale /= horizontalDistance
        
        viewX *= scale
        viewY *= scale
    END
    
    float newLookAtX, newLookAtY, newLookAtZ
    
    newLookAtX = cameraX
    newLookAtX += viewX
    newLookAtY = cameraY
    newLookAtY += viewY
    newLookAtZ = cameraZ
    newLookAtZ += viewZ
    
    cleo_return 3 newLookAtX newLookAtY newLookAtZ
end


export function moveCamera(cameraX: float, cameraY: float, cameraZ: float, lookAtX: float, lookAtY: float, lookAtZ: float, forwardMove: float, rightMove: float): float, float, float, float, float, float
    
    float viewX = lookAtX
    viewX -= cameraX
    
    float viewY = lookAtY
    viewY -= cameraY
    
    float viewZ = lookAtZ
    viewZ -= cameraZ
    
    float moveX, moveY, moveZ
    
    moveX, moveY, moveZ = calculateMove(viewX, viewY, viewZ, forwardMove, rightMove)
    
    cameraX += moveX
    cameraY += moveY
    cameraZ += moveZ
    
    lookAtX = cameraX
    lookAtX += viewX
    
    lookAtY = cameraY
    lookAtY += viewY
    
    lookAtZ = cameraZ
    lookAtZ += viewZ
    
    cleo_return 6 cameraX, cameraY, cameraZ, lookAtX, lookAtY, lookAtZ
end

function calculateMove(viewX: float, viewY: float, viewZ: float, forwardMove: float, rightMove: float): float, float, float

    float dirX, dirY, dirZ
    
    dirX, dirY, dirZ = normalizeVector(viewX, viewY, viewZ)
    
    float rightX, rightY, rightZ
    
    rightX = dirY
    rightY = dirX
    
    rightY *= -1.0
    rightZ = 0.0
    
    rightX, rightY, rightZ = normalizeVector(rightX, rightY, rightZ)
    
    rightX *= rightMove
    rightY *= rightMove
    rightZ *= rightMove
    
    float moveX, moveY, moveZ
    
    moveX = dirX
    moveX *= forwardMove
    moveX += rightX
    
    moveY = dirY
    moveY *= forwardMove
    moveY += rightY
    
    moveZ = dirZ
    moveZ *= forwardMove
    moveZ += rightZ
    
    moveX, moveY, moveZ = normalizeVector(moveX, moveY, moveZ)
    
    //Speed is constant for now 0.5
    moveX *= 0.5
    moveY *= 0.5
    moveZ *= 0.5
    
    cleo_return 3 moveX, moveY, moveZ
    
end

function normalizeVector(x: float, y: float, z: float): float, float, float
    
    float sqrX = Math.Pow(x, 2.0)
    float sqrY = Math.Pow(y, 2.0)
    float sqrZ = Math.Pow(z, 2.0)
    
    float sum = sqrX
    sum += sqrY
    sum += sqrZ
    
    float length = Math.Sqrt(sum)
    
    float resultX, resultY, resultZ
    
    if length <> 0.0
    then
        resultX = x
        resultX /= length
        
        resultY = y
        resultY /= length
        
        resultZ = Z
        resultZ /= length
    else
        resultX = 0.0
        resultY = 0.0
        resultZ = 0.0
    end
    
    cleo_return 3 resultX, resultY, resultZ
end;  __SBFTR 