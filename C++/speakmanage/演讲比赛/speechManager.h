<<<<<<< HEAD
<<<<<<< HEAD
#pragma once
#include<iostream>
using namespace std;
#include<vector>
#include<map>
#include "speaker.h"
#include<algorithm>
#include<deque>
#include<functional>
#include<numeric>
#include<string>
#include<fstream>
#include<Windows.h>


//设计演讲管理类
class SpeechManager
{
public:
	//构造函数
	SpeechManager();

	//菜单功能
	void show_Menu();


	//退出系统
	void existSystem();


	//析构函数
	~SpeechManager();

	//初始化属性和容器
	void initSpeech();

	//创建12名选手
	void createSpeaker();


	//开始比赛  比赛整个流程控制函数
	void startSpeech();


	//抽签
	void speechDraw();

	//比赛
	void speechContest();
	
	//显示得分
	void showScore();

	//保存记录
	void saveRecored();

	//读取记录
	void loadRecord();

	//显示往届记录
	void showRecord();

	//清空文件
	void clearRecord();


	//判断文件是否为空
	bool fileIsEmpty;
	
	//存放往届记录的容器
	map<int, vector<string>>m_Record;   //防止选手编号重复


	//成员属性
	 
	//保存第一轮比赛选手编号容器  12人
	vector<int>v1;

	//第一轮晋级选手编号容器  6人
	vector<int>v2;

	//胜出的前三名选手编号容器   3人
	vector<int>vVictory;

	//存放编号  以及对应的 具体选手 的容器
	map<int, Speaker>m_Speaker;

	//存放比赛轮数
	int m_Index;
=======
#pragma once
#include<iostream>
using namespace std;
#include<vector>
#include<map>
#include "speaker.h"
#include<algorithm>
#include<deque>
#include<functional>
#include<numeric>
#include<string>
#include<fstream>
#include<Windows.h>


//设计演讲管理类
class SpeechManager
{
public:
	//构造函数
	SpeechManager();

	//菜单功能
	void show_Menu();


	//退出系统
	void existSystem();


	//析构函数
	~SpeechManager();

	//初始化属性和容器
	void initSpeech();

	//创建12名选手
	void createSpeaker();


	//开始比赛  比赛整个流程控制函数
	void startSpeech();


	//抽签
	void speechDraw();

	//比赛
	void speechContest();
	
	//显示得分
	void showScore();

	//保存记录
	void saveRecored();

	//读取记录
	void loadRecord();

	//显示往届记录
	void showRecord();

	//清空文件
	void clearRecord();


	//判断文件是否为空
	bool fileIsEmpty;
	
	//存放往届记录的容器
	map<int, vector<string>>m_Record;   //防止选手编号重复


	//成员属性
	 
	//保存第一轮比赛选手编号容器  12人
	vector<int>v1;

	//第一轮晋级选手编号容器  6人
	vector<int>v2;

	//胜出的前三名选手编号容器   3人
	vector<int>vVictory;

	//存放编号  以及对应的 具体选手 的容器
	map<int, Speaker>m_Speaker;

	//存放比赛轮数
	int m_Index;
>>>>>>> 64b98629441b4b81bfb2bf12d3fa74438f1d4a8e
=======
#pragma once
#include<iostream>
using namespace std;
#include<vector>
#include<map>
#include "speaker.h"
#include<algorithm>
#include<deque>
#include<functional>
#include<numeric>
#include<string>
#include<fstream>
#include<Windows.h>


//设计演讲管理类
class SpeechManager
{
public:
	//构造函数
	SpeechManager();

	//菜单功能
	void show_Menu();


	//退出系统
	void existSystem();


	//析构函数
	~SpeechManager();

	//初始化属性和容器
	void initSpeech();

	//创建12名选手
	void createSpeaker();


	//开始比赛  比赛整个流程控制函数
	void startSpeech();


	//抽签
	void speechDraw();

	//比赛
	void speechContest();
	
	//显示得分
	void showScore();

	//保存记录
	void saveRecored();

	//读取记录
	void loadRecord();

	//显示往届记录
	void showRecord();

	//清空文件
	void clearRecord();


	//判断文件是否为空
	bool fileIsEmpty;
	
	//存放往届记录的容器
	map<int, vector<string>>m_Record;   //防止选手编号重复


	//成员属性
	 
	//保存第一轮比赛选手编号容器  12人
	vector<int>v1;

	//第一轮晋级选手编号容器  6人
	vector<int>v2;

	//胜出的前三名选手编号容器   3人
	vector<int>vVictory;

	//存放编号  以及对应的 具体选手 的容器
	map<int, Speaker>m_Speaker;

	//存放比赛轮数
	int m_Index;
>>>>>>> 64b98629441b4b81bfb2bf12d3fa74438f1d4a8e
};