#pragma once

#include <glad/glad.h>

#include <glm/glm.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <fstream>
#include <sstream>
#include <iostream>

class Shader {

	public:
		Shader(std::string vertexPath, std::string fragmentPath);

		void use();
		void setBool(std::string name, bool value);
		void setInt(std::string name, int value);
		void setFloat(std::string name, float value);
		void setVec3(std::string name, float x, float y, float z);
		void setVec3(std::string name, const glm::vec3 &vec);
		void setVec4(std::string name, float x, float y, float z, float w);
		void setVec4(std::string name, const glm::vec4 &vec);
		void setMat4(std::string name, const glm::mat4 &mat);

	private:
		unsigned int ID;
		unsigned int uniformLoc(std::string name);
};
