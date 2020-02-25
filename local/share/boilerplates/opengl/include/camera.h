#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <iostream>

using namespace glm;

enum Direction {
	RIGHT, UP, LEFT, DOWN
};

class Camera {
public:
	vec3 cameraPos;
	vec3 cameraFront;
	vec3 cameraRight;
	vec3 cameraUp;

	const vec3 worldUp = vec3(0.0f, 1.0f, 0.0f);

	bool constrainToGround = false;

	// Mouse update
	float lastX = 0;
	float lastY = 0;
	bool firstMouse = true;

	const float cameraSpeed = 2.5f;
	const float sensitivity = .1f;

	float yaw, pitch;

	Camera()
	{
		cameraPos = vec3(0.0f, 0.0f, 3.0f);
		yaw = -90.0f;
		pitch = 0.0f;
		updateCameraVectors();
	}

	mat4 getView()
	{
		return lookAt(cameraPos, cameraPos + cameraFront, worldUp);
	}

	void move(Direction moveDir, float deltaTime)
	{
		float speed = cameraSpeed * deltaTime;
		vec3 forwardDir = constrainToGround ? normalize(vec3(cameraFront.x, 0.0f, cameraFront.z)) : cameraFront;

		switch (moveDir) {
		case UP:
			cameraPos += speed * forwardDir;
			break;
		case DOWN:
			cameraPos -= speed * forwardDir;
			break;
		case LEFT:
			cameraPos -= speed * normalize(cross(cameraFront, worldUp));
			break;
		case RIGHT:
			cameraPos += speed * normalize(cross(cameraFront, worldUp));
			break;
		}
	}

	void updateMouse(float xpos, float ypos)
	{
		if (!firstMouse) {
			yaw += (xpos - lastX) * sensitivity;
			pitch = clamp(pitch + (lastY - ypos) * sensitivity, -89.0f, 89.0f);
			updateCameraVectors();
		} else {
			firstMouse = false;
		}

		lastX = xpos;
		lastY = ypos;
	}

	void setConstrainToGround(bool val)
	{
		constrainToGround = val;
	}

private:
	void updateCameraVectors()
	{
		vec3 dir = {
			cos(radians(pitch)) * cos(radians(yaw)),
			sin(radians(pitch)),
			cos(radians(pitch)) * sin(radians(yaw)),
		};

		cameraFront = normalize(dir);
		cameraRight = normalize(cross(cameraFront, worldUp));
		cameraUp = normalize(cross(cameraRight, cameraFront));
	}
};
