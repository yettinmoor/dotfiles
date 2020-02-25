#include <glad/glad.h>

#include <glm/glm.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <string>
#include <fstream>
#include <sstream>
#include <iostream>

#include "shader.h"

Shader::Shader(std::string vertexPath, std::string fragmentPath)
{
	std::string vertexCode, fragmentCode;
	std::ifstream vShaderFile, fShaderFile;

	vShaderFile.exceptions(std::ifstream::failbit | std::ifstream::badbit);
	fShaderFile.exceptions(std::ifstream::failbit | std::ifstream::badbit);

	try {
		vShaderFile.open("shaders/" + vertexPath);
		std::stringstream vShaderStream;
		vShaderStream << vShaderFile.rdbuf();
		vShaderFile.close();
		vertexCode = vShaderStream.str();
	}

	catch(std::ifstream::failure& e) {
		std::cerr << "ERROR::VERTEX_SHADER::FILE_NOT_SUCCESFULLY_READ\n"
			<< e.what() << '\n' << vertexPath << std::endl;
		return;
	}

	try {
		fShaderFile.open("shaders/" + fragmentPath);
		std::stringstream fShaderStream;
		fShaderStream << fShaderFile.rdbuf();
		fShaderFile.close();
		fragmentCode = fShaderStream.str();
	}

	catch(std::ifstream::failure& e) {
		std::cerr << "ERROR::FRAGMENT_SHADER::FILE_NOT_SUCCESFULLY_READ\n"
			<< e.what() << '\n' << fragmentPath << std::endl;
		return;
	}

	const char* vShaderCode = vertexCode.c_str();
	const char* fShaderCode = fragmentCode.c_str();

	// Compilation
	unsigned int vertex, fragment;
	int success;
	char infoLog[512];

	// vShader
	vertex = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertex, 1, &vShaderCode, NULL);
	glCompileShader(vertex);

	glGetShaderiv(vertex, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetShaderInfoLog(vertex, 512, NULL, infoLog);
		std::cerr << "ERROR::SHADER::VERTEX::COMPILATION_FAILED\n"
			<< infoLog << std::endl;
	};

	// fShader
	fragment = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragment, 1, &fShaderCode, NULL);
	glCompileShader(fragment);

	glGetShaderiv(fragment, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetShaderInfoLog(vertex, 512, NULL, infoLog);
		std::cerr << "ERROR::SHADER::FRAGMENT::COMPILATION_FAILED\n"
			<< infoLog << std::endl;
	};

	// Shader program
	ID = glCreateProgram();
	glAttachShader(ID, vertex);
	glAttachShader(ID, fragment);
	glLinkProgram(ID);

	glGetProgramiv(ID, GL_LINK_STATUS, &success);
	if (!success) {
		glGetProgramInfoLog(ID, 512, NULL, infoLog);
		std::cerr << "ERROR::SHADER::PROGRAM::LINKING_FAILED\n"
			<< infoLog << std::endl;
	}

	// Cleanup
	glDeleteShader(vertex);
	glDeleteShader(fragment);
}

void Shader::use()
{
	glUseProgram(ID);
}

void Shader::setBool(std::string name, bool value)
{
	glUniform1i(uniformLoc(name), (int)value);
}

void Shader::setInt(std::string name, int value)
{
	glUniform1i(uniformLoc(name), value);
}

void Shader::setFloat(std::string name, float value)
{
	glUniform1f(uniformLoc(name), value);
}

void Shader::setVec3(std::string name, float x, float y, float z)
{
	glUniform3f(uniformLoc(name), x, y, z);
}

void Shader::setVec3(std::string name, const glm::vec3 &vec)
{
	glUniform3fv(uniformLoc(name), 1, &vec[0]);
}

void Shader::setVec4(std::string name, float x, float y, float z, float w)
{
	glUniform4f(uniformLoc(name), x, y, z, w);
}

void Shader::setVec4(std::string name, const glm::vec4 &vec)
{
	glUniform4fv(uniformLoc(name), 1, &vec[0]);
}

void Shader::setMat4(std::string name, const glm::mat4 &mat)
{
	glUniformMatrix4fv(uniformLoc(name), 1, GL_FALSE, &mat[0][0]);
}

unsigned int Shader::uniformLoc(std::string name)
{
	return glGetUniformLocation(ID, name.c_str());
}
