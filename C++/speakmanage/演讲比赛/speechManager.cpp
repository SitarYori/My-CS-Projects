<<<<<<< HEAD
<<<<<<< HEAD
#include"speechManager.h"

//构造函数
SpeechManager::SpeechManager()
{
	//初始化容器和属性
	this->initSpeech();

	//创建12名选手
	this->createSpeaker();

	//加载往届记录
	this->loadRecord();

}


//菜单功能
void SpeechManager::show_Menu()
{
	cout << "*****************************************" << endl;
	cout << "*************欢迎参加演讲比赛************" << endl;
	cout << "*************1、开始演讲比赛*************" << endl;
	cout << "*************2、查看往届记录*************" << endl;
	cout << "*************3、清空比赛记录*************" << endl;
	cout << "*************0、退出比赛程序*************" << endl;
	cout << "*****************************************" << endl;
	cout << endl;

}

//退出系统
void SpeechManager::existSystem()
{
	cout << "欢迎下次使用！" << endl;
	system("pause");
	exit(0);
}


void SpeechManager::initSpeech()
{
	//容器都置空
	this->v1.clear();
	this->v2.clear();
	this->vVictory.clear();
	this->m_Speaker.clear();

	//初始化比赛轮数
		this->m_Index = 1;

	//初始化记录容器
		this->m_Record.clear();
}

//初始化创建12名选手
void SpeechManager::createSpeaker()
{
	string nameSeed = "ABCDEFGHIJKL";
	for (int i = 0; i < nameSeed.size(); i++)
	{
		string name = "选手";
		name += nameSeed[i];

		//创建具体选手
		Speaker sp;
		sp.m_Name = name;

		for (int j=0;j<2;j++)
		{
			sp.m_Score[j] = 0;  //两轮得分重置 为0；
		}

		//创建选手编号并放入v1容器中(12名选手的编号)
		this->v1.push_back(i + 10001);

		//创建选手的编号 以及对于的选手 放到map容器中
		this->m_Speaker.insert(make_pair(i + 10001, sp));  //map容器中每一个数据都是成对出现//value ->sp 具体的选手
	}
}


//开始比赛  比赛整个流程控制函数
void SpeechManager::startSpeech()
{
	//第一轮比赛开始

	//1、抽签
	this->speechDraw();

	//2、比赛
	this->speechContest();

	//3、显示晋级成果
	this->showScore();

	//第二轮比赛开始
	this->m_Index++;

	//1、抽签
	this->speechDraw();

	//2、比赛
	this->speechContest();

	//3、显示最终结果
	this->showScore();

	//4、保存分数到文件中
	this->saveRecored();

	//重置比赛
	
	//初始化属性
	this->initSpeech();

	//创建选手
	this->createSpeaker();

	//获取往届记录
	this->loadRecord();

	cout << "本届比赛完毕！" << endl;
	system("pause");
	system("cls");
}

//抽签

void SpeechManager::speechDraw()
{
	cout << "第" << this->m_Index << "轮的选手正在抽签" << endl;
	cout << "------------------------" << endl;
	cout << "抽签后的演讲顺序如下：" << endl;

	if (this->m_Index == 1)
	{
		//第一轮比赛
		random_shuffle(v1.begin(), v1.end());//random. /打乱顺序
		for (vector<int>::iterator it = v1.begin(); it != v1.end(); it++)//利用迭代器的方式输出
		{
			cout << *it << " ";
		}
		cout << endl;
	}
	else
	{
		//第二轮比赛
		random_shuffle(v2.begin(), v2.end());
		for (vector<int>::iterator it = v2.begin(); it != v2.end(); it++)
		{
			cout << *it<< " ";
		}
		cout << endl;
	}
	cout << "-----------------------" << endl;
	system("pause");
	cout << endl;
}


//比赛
void SpeechManager::speechContest()
{
	cout << "--------------第" << this->m_Index << "轮比赛正式开始！----------------" << endl;
	cout << "评委正在打分！请稍后......" << endl;

	//准备一个临时的容器存放小组成绩

	multimap<double, int, greater<int>>groupScore;//临时容器，保存key分数 value选手编号   multimap允许分数重复

	int num = 0;//记录人员个数,6人为一组
		
	vector<int>v_Src;//比赛选手的容器

	if (this->m_Index == 1)
	{
		v_Src = v1;
	}
	else
	{
		v_Src = v2;
	}
	//遍历所有参赛选手进行比赛
	for (vector<int>::iterator it = v_Src.begin(); it != v_Src.end(); it++)
	{
		num++;
		//评委打分
		deque<double>d;//接收每个人的分数
		for (int i = 0; i < 10; i++)
		{
			double score = (rand() % 401 + 600)/ 10.f;      //600~1000  随机数

			//cout << score << " ";//10个评委具体打分  有异议可以查

			d.push_back(score);
		}
		//cout << endl;

		sort(d.begin(), d.end(), greater<double>());  //排序从大到小

		d.pop_front();  //去除最高分
		d.pop_back();  //去除最低分
		double  sum = accumulate(d.begin(), d.end(), 0.0f);//累加总分
		double avg = sum / (double)d.size();//平均分
		


		//打印每个人的平均分
		
		//cout << "编号：" << *it << "姓名：" << this->m_Speaker[*it].m_Name << "获取平均分：" << avg << endl;  //打印平均分
		
		//将平均分放到map容器中
		this->m_Speaker[*it].m_Score[this->m_Index - 1] = avg;

		//将打分数据 放入临时容器在中..//6人一组，用临时容器保存
		groupScore.insert(make_pair(avg, *it));//key是平均得分，value是具体选手编号 //groupScore小组容器

		Sleep(600);


		//每六人取出前三名

		if (num % 6 == 0)
		{
			cout << "第" << num / 6 << "小组比赛名次：" << endl;
			for (multimap<double, int, greater<double>>::iterator it = groupScore.begin(); it != groupScore.end(); it++)
			{
				cout << "编号：" << it->second << "  姓名：" << this->m_Speaker[it->second].m_Name << "  成绩：" << this->m_Speaker
					[it->second].m_Score[this->m_Index - 1] << endl;
			}

			int count = 0;

			//取走前三名

			for (multimap<double,int,greater<double>>::iterator it = groupScore.begin(); it != groupScore.end()&&count<3; it++,count++)
			{
				if (this->m_Index == 1)
				{
					v2.push_back((*it).second);
				}
				else
				{
					vVictory.push_back((*it).second);
				}
			}
			//取走前三个放入下一个
			groupScore.clear();//小组容器清空
			cout << endl;
		}
		

	}

	cout << "--------------第" << this->m_Index << "轮比赛完毕！----------------" << endl;
	system("pause");
	//cout << endl;
}

//显示得分
void SpeechManager::showScore()
{
	cout << "-------------第" << this->m_Index << "轮晋级选手信息如下：----------------" << endl;

	vector<int>v;

	if (this->m_Index == 1)
	{
		v = v2;
	}
	else
	{
		v = vVictory;
	}
	for (vector<int>::iterator it = v.begin(); it != v.end(); it++)
	{
		cout << "选手编号：" << *it << "  姓名：" << m_Speaker[*it].m_Name << "  得分：" <<m_Speaker[*it].m_Score[this->m_Index - 1] << endl;
	}
	cout << endl;

	system("pause");
	system("cls");
	this->show_Menu();
}
//保存记录
void SpeechManager::saveRecored()
{
	ofstream ofs;
	ofs.open("speech.csv", ios::out | ios::app);//用追加的方式写文件//用输出的方式打开文件   --  写文件

	//将每个选手的数据写入文件中
	for (vector<int>::iterator it = vVictory.begin(); it != vVictory.end(); it++)
	{
		ofs << *it << "," << this->m_Speaker[*it].m_Score[1] << ",";

	}
	ofs << endl;

	//关闭文件
	ofs.close();

	cout << "记录已经保存！" << endl;

	//更改文件不为空状态
	this->fileIsEmpty = false;//有记录了，文件不为空
}


//保存记录
void SpeechManager::loadRecord()
{
	ifstream ifs("speech.csv",ios::in);//输入流对象 读取文件

	if (!ifs.is_open())
	{
		this->fileIsEmpty = true;
		cout << "文件不存在！" << endl;
		ifs.close();
		return;
	}

	//文件清空情况
	char ch;
	ifs >> ch;
	if (ifs.eof())
	{
		cout << "文件为空！"<<endl;
		this->fileIsEmpty = true;
		ifs.close();
		return;
	}

	//文件不为空
	this->fileIsEmpty = false;

	ifs.putback(ch);//将上面读取的单个字符 放回来

	string data;
	int index = 0;

	while (ifs >> data)
	{
		//cout << data << endl;
		//10008,88.9625,10004,86.7,10002,81.125,

		vector<string>v; //为了存放六个string字符串
		int pos = -1; //查到“，”位置的变量
		int start = 0;

		while (true)
		{

			pos = data.find(",", start);//从0开始找
			if (pos == -1)
			{
				break;////未找到情况  break返回
			}
			string temp = data.substr(start, pos - start);   //找到了"，"进行分割 参数1 起始位置，参数2 截取长度
			//cout << temp << endl;
			 v.push_back(temp);
			start = pos + 1;
		}
		this->m_Record.insert(make_pair(index, v));
		index++;
	}
	ifs.close();

	/*for (map<int, vector<string>>::iterator it = this->m_Record.begin(); it != m_Record.end(); it++)
	{
		cout << it->first << "冠军编号：" << it->second[0] << "分数：" << it->second[1] << endl;
	}*/
}


//显示往届记录
void SpeechManager::showRecord()
{
	if (this->fileIsEmpty)
	{
		cout << "文件不存在，或记录为空！" << endl;
	}
	else
	{
		for (int i = 0; i < this->m_Record.size(); i++)
		{
		cout << "第" << i + 1 << "届"
			<< "冠军编号：" << this->m_Record[i][0] <<"\t" << "得分：" << this->m_Record[i][1] << "\t "
			<< "亚军编号：" << this->m_Record[i][2] <<"\t" << "得分：" << this->m_Record[i][3] << "\t "
			<< "季军编号：" << this->m_Record[i][4] <<"\t" << "得分：" << this->m_Record[i][5] << endl;
		}
	}
	system("pause");
	system("cls");
}


//清空文件
void SpeechManager::clearRecord() 
{
	cout << "是否确定清空文件？" << endl;
	cout << "1、确定" << endl;
	cout << "2、返回" << endl;

	int select = 0;
	cin >> select;

	if (select == 1)
	{
		//打开模式 ios::truns如果存在删除文件并重新创建

		ofstream ofs("speech.csv",ios::trunc);//确认清空
		ofs.close();

		//初始化容器和属性
		this->initSpeech();

		//创建12名选手
		this->createSpeaker();

		//加载获取往届记录
		this->loadRecord();

		cout << "清空成功！" << endl;

	}
	system("pause");
	system("cls");

}

//析构函数
SpeechManager::~SpeechManager()
{


=======
#include"speechManager.h"

//构造函数
SpeechManager::SpeechManager()
{
	//初始化容器和属性
	this->initSpeech();

	//创建12名选手
	this->createSpeaker();

	//加载往届记录
	this->loadRecord();

}


//菜单功能
void SpeechManager::show_Menu()
{
	cout << "*****************************************" << endl;
	cout << "*************欢迎参加演讲比赛************" << endl;
	cout << "*************1、开始演讲比赛*************" << endl;
	cout << "*************2、查看往届记录*************" << endl;
	cout << "*************3、清空比赛记录*************" << endl;
	cout << "*************0、退出比赛程序*************" << endl;
	cout << "*****************************************" << endl;
	cout << endl;

}

//退出系统
void SpeechManager::existSystem()
{
	cout << "欢迎下次使用！" << endl;
	system("pause");
	exit(0);
}


void SpeechManager::initSpeech()
{
	//容器都置空
	this->v1.clear();
	this->v2.clear();
	this->vVictory.clear();
	this->m_Speaker.clear();

	//初始化比赛轮数
		this->m_Index = 1;

	//初始化记录容器
		this->m_Record.clear();
}

//初始化创建12名选手
void SpeechManager::createSpeaker()
{
	string nameSeed = "ABCDEFGHIJKL";
	for (int i = 0; i < nameSeed.size(); i++)
	{
		string name = "选手";
		name += nameSeed[i];

		//创建具体选手
		Speaker sp;
		sp.m_Name = name;

		for (int j=0;j<2;j++)
		{
			sp.m_Score[j] = 0;  //两轮得分重置 为0；
		}

		//创建选手编号并放入v1容器中(12名选手的编号)
		this->v1.push_back(i + 10001);

		//创建选手的编号 以及对于的选手 放到map容器中
		this->m_Speaker.insert(make_pair(i + 10001, sp));  //map容器中每一个数据都是成对出现//value ->sp 具体的选手
	}
}


//开始比赛  比赛整个流程控制函数
void SpeechManager::startSpeech()
{
	//第一轮比赛开始

	//1、抽签
	this->speechDraw();

	//2、比赛
	this->speechContest();

	//3、显示晋级成果
	this->showScore();

	//第二轮比赛开始
	this->m_Index++;

	//1、抽签
	this->speechDraw();

	//2、比赛
	this->speechContest();

	//3、显示最终结果
	this->showScore();

	//4、保存分数到文件中
	this->saveRecored();

	//重置比赛
	
	//初始化属性
	this->initSpeech();

	//创建选手
	this->createSpeaker();

	//获取往届记录
	this->loadRecord();

	cout << "本届比赛完毕！" << endl;
	system("pause");
	system("cls");
}

//抽签

void SpeechManager::speechDraw()
{
	cout << "第" << this->m_Index << "轮的选手正在抽签" << endl;
	cout << "------------------------" << endl;
	cout << "抽签后的演讲顺序如下：" << endl;

	if (this->m_Index == 1)
	{
		//第一轮比赛
		random_shuffle(v1.begin(), v1.end());//random. /打乱顺序
		for (vector<int>::iterator it = v1.begin(); it != v1.end(); it++)//利用迭代器的方式输出
		{
			cout << *it << " ";
		}
		cout << endl;
	}
	else
	{
		//第二轮比赛
		random_shuffle(v2.begin(), v2.end());
		for (vector<int>::iterator it = v2.begin(); it != v2.end(); it++)
		{
			cout << *it<< " ";
		}
		cout << endl;
	}
	cout << "-----------------------" << endl;
	system("pause");
	cout << endl;
}


//比赛
void SpeechManager::speechContest()
{
	cout << "--------------第" << this->m_Index << "轮比赛正式开始！----------------" << endl;
	cout << "评委正在打分！请稍后......" << endl;

	//准备一个临时的容器存放小组成绩

	multimap<double, int, greater<int>>groupScore;//临时容器，保存key分数 value选手编号   multimap允许分数重复

	int num = 0;//记录人员个数,6人为一组
		
	vector<int>v_Src;//比赛选手的容器

	if (this->m_Index == 1)
	{
		v_Src = v1;
	}
	else
	{
		v_Src = v2;
	}
	//遍历所有参赛选手进行比赛
	for (vector<int>::iterator it = v_Src.begin(); it != v_Src.end(); it++)
	{
		num++;
		//评委打分
		deque<double>d;//接收每个人的分数
		for (int i = 0; i < 10; i++)
		{
			double score = (rand() % 401 + 600)/ 10.f;      //600~1000  随机数

			//cout << score << " ";//10个评委具体打分  有异议可以查

			d.push_back(score);
		}
		//cout << endl;

		sort(d.begin(), d.end(), greater<double>());  //排序从大到小

		d.pop_front();  //去除最高分
		d.pop_back();  //去除最低分
		double  sum = accumulate(d.begin(), d.end(), 0.0f);//累加总分
		double avg = sum / (double)d.size();//平均分
		


		//打印每个人的平均分
		
		//cout << "编号：" << *it << "姓名：" << this->m_Speaker[*it].m_Name << "获取平均分：" << avg << endl;  //打印平均分
		
		//将平均分放到map容器中
		this->m_Speaker[*it].m_Score[this->m_Index - 1] = avg;

		//将打分数据 放入临时容器在中..//6人一组，用临时容器保存
		groupScore.insert(make_pair(avg, *it));//key是平均得分，value是具体选手编号 //groupScore小组容器

		Sleep(600);


		//每六人取出前三名

		if (num % 6 == 0)
		{
			cout << "第" << num / 6 << "小组比赛名次：" << endl;
			for (multimap<double, int, greater<double>>::iterator it = groupScore.begin(); it != groupScore.end(); it++)
			{
				cout << "编号：" << it->second << "  姓名：" << this->m_Speaker[it->second].m_Name << "  成绩：" << this->m_Speaker
					[it->second].m_Score[this->m_Index - 1] << endl;
			}

			int count = 0;

			//取走前三名

			for (multimap<double,int,greater<double>>::iterator it = groupScore.begin(); it != groupScore.end()&&count<3; it++,count++)
			{
				if (this->m_Index == 1)
				{
					v2.push_back((*it).second);
				}
				else
				{
					vVictory.push_back((*it).second);
				}
			}
			//取走前三个放入下一个
			groupScore.clear();//小组容器清空
			cout << endl;
		}
		

	}

	cout << "--------------第" << this->m_Index << "轮比赛完毕！----------------" << endl;
	system("pause");
	//cout << endl;
}

//显示得分
void SpeechManager::showScore()
{
	cout << "-------------第" << this->m_Index << "轮晋级选手信息如下：----------------" << endl;

	vector<int>v;

	if (this->m_Index == 1)
	{
		v = v2;
	}
	else
	{
		v = vVictory;
	}
	for (vector<int>::iterator it = v.begin(); it != v.end(); it++)
	{
		cout << "选手编号：" << *it << "  姓名：" << m_Speaker[*it].m_Name << "  得分：" <<m_Speaker[*it].m_Score[this->m_Index - 1] << endl;
	}
	cout << endl;

	system("pause");
	system("cls");
	this->show_Menu();
}
//保存记录
void SpeechManager::saveRecored()
{
	ofstream ofs;
	ofs.open("speech.csv", ios::out | ios::app);//用追加的方式写文件//用输出的方式打开文件   --  写文件

	//将每个选手的数据写入文件中
	for (vector<int>::iterator it = vVictory.begin(); it != vVictory.end(); it++)
	{
		ofs << *it << "," << this->m_Speaker[*it].m_Score[1] << ",";

	}
	ofs << endl;

	//关闭文件
	ofs.close();

	cout << "记录已经保存！" << endl;

	//更改文件不为空状态
	this->fileIsEmpty = false;//有记录了，文件不为空
}


//保存记录
void SpeechManager::loadRecord()
{
	ifstream ifs("speech.csv",ios::in);//输入流对象 读取文件

	if (!ifs.is_open())
	{
		this->fileIsEmpty = true;
		cout << "文件不存在！" << endl;
		ifs.close();
		return;
	}

	//文件清空情况
	char ch;
	ifs >> ch;
	if (ifs.eof())
	{
		cout << "文件为空！"<<endl;
		this->fileIsEmpty = true;
		ifs.close();
		return;
	}

	//文件不为空
	this->fileIsEmpty = false;

	ifs.putback(ch);//将上面读取的单个字符 放回来

	string data;
	int index = 0;

	while (ifs >> data)
	{
		//cout << data << endl;
		//10008,88.9625,10004,86.7,10002,81.125,

		vector<string>v; //为了存放六个string字符串
		int pos = -1; //查到“，”位置的变量
		int start = 0;

		while (true)
		{

			pos = data.find(",", start);//从0开始找
			if (pos == -1)
			{
				break;////未找到情况  break返回
			}
			string temp = data.substr(start, pos - start);   //找到了"，"进行分割 参数1 起始位置，参数2 截取长度
			//cout << temp << endl;
			 v.push_back(temp);
			start = pos + 1;
		}
		this->m_Record.insert(make_pair(index, v));
		index++;
	}
	ifs.close();

	/*for (map<int, vector<string>>::iterator it = this->m_Record.begin(); it != m_Record.end(); it++)
	{
		cout << it->first << "冠军编号：" << it->second[0] << "分数：" << it->second[1] << endl;
	}*/
}


//显示往届记录
void SpeechManager::showRecord()
{
	if (this->fileIsEmpty)
	{
		cout << "文件不存在，或记录为空！" << endl;
	}
	else
	{
		for (int i = 0; i < this->m_Record.size(); i++)
		{
		cout << "第" << i + 1 << "届"
			<< "冠军编号：" << this->m_Record[i][0] <<"\t" << "得分：" << this->m_Record[i][1] << "\t "
			<< "亚军编号：" << this->m_Record[i][2] <<"\t" << "得分：" << this->m_Record[i][3] << "\t "
			<< "季军编号：" << this->m_Record[i][4] <<"\t" << "得分：" << this->m_Record[i][5] << endl;
		}
	}
	system("pause");
	system("cls");
}


//清空文件
void SpeechManager::clearRecord() 
{
	cout << "是否确定清空文件？" << endl;
	cout << "1、确定" << endl;
	cout << "2、返回" << endl;

	int select = 0;
	cin >> select;

	if (select == 1)
	{
		//打开模式 ios::truns如果存在删除文件并重新创建

		ofstream ofs("speech.csv",ios::trunc);//确认清空
		ofs.close();

		//初始化容器和属性
		this->initSpeech();

		//创建12名选手
		this->createSpeaker();

		//加载获取往届记录
		this->loadRecord();

		cout << "清空成功！" << endl;

	}
	system("pause");
	system("cls");

}

//析构函数
SpeechManager::~SpeechManager()
{


>>>>>>> 64b98629441b4b81bfb2bf12d3fa74438f1d4a8e
=======
#include"speechManager.h"

//构造函数
SpeechManager::SpeechManager()
{
	//初始化容器和属性
	this->initSpeech();

	//创建12名选手
	this->createSpeaker();

	//加载往届记录
	this->loadRecord();

}


//菜单功能
void SpeechManager::show_Menu()
{
	cout << "*****************************************" << endl;
	cout << "*************欢迎参加演讲比赛************" << endl;
	cout << "*************1、开始演讲比赛*************" << endl;
	cout << "*************2、查看往届记录*************" << endl;
	cout << "*************3、清空比赛记录*************" << endl;
	cout << "*************0、退出比赛程序*************" << endl;
	cout << "*****************************************" << endl;
	cout << endl;

}

//退出系统
void SpeechManager::existSystem()
{
	cout << "欢迎下次使用！" << endl;
	system("pause");
	exit(0);
}


void SpeechManager::initSpeech()
{
	//容器都置空
	this->v1.clear();
	this->v2.clear();
	this->vVictory.clear();
	this->m_Speaker.clear();

	//初始化比赛轮数
		this->m_Index = 1;

	//初始化记录容器
		this->m_Record.clear();
}

//初始化创建12名选手
void SpeechManager::createSpeaker()
{
	string nameSeed = "ABCDEFGHIJKL";
	for (int i = 0; i < nameSeed.size(); i++)
	{
		string name = "选手";
		name += nameSeed[i];

		//创建具体选手
		Speaker sp;
		sp.m_Name = name;

		for (int j=0;j<2;j++)
		{
			sp.m_Score[j] = 0;  //两轮得分重置 为0；
		}

		//创建选手编号并放入v1容器中(12名选手的编号)
		this->v1.push_back(i + 10001);

		//创建选手的编号 以及对于的选手 放到map容器中
		this->m_Speaker.insert(make_pair(i + 10001, sp));  //map容器中每一个数据都是成对出现//value ->sp 具体的选手
	}
}


//开始比赛  比赛整个流程控制函数
void SpeechManager::startSpeech()
{
	//第一轮比赛开始

	//1、抽签
	this->speechDraw();

	//2、比赛
	this->speechContest();

	//3、显示晋级成果
	this->showScore();

	//第二轮比赛开始
	this->m_Index++;

	//1、抽签
	this->speechDraw();

	//2、比赛
	this->speechContest();

	//3、显示最终结果
	this->showScore();

	//4、保存分数到文件中
	this->saveRecored();

	//重置比赛
	
	//初始化属性
	this->initSpeech();

	//创建选手
	this->createSpeaker();

	//获取往届记录
	this->loadRecord();

	cout << "本届比赛完毕！" << endl;
	system("pause");
	system("cls");
}

//抽签

void SpeechManager::speechDraw()
{
	cout << "第" << this->m_Index << "轮的选手正在抽签" << endl;
	cout << "------------------------" << endl;
	cout << "抽签后的演讲顺序如下：" << endl;

	if (this->m_Index == 1)
	{
		//第一轮比赛
		random_shuffle(v1.begin(), v1.end());//random. /打乱顺序
		for (vector<int>::iterator it = v1.begin(); it != v1.end(); it++)//利用迭代器的方式输出
		{
			cout << *it << " ";
		}
		cout << endl;
	}
	else
	{
		//第二轮比赛
		random_shuffle(v2.begin(), v2.end());
		for (vector<int>::iterator it = v2.begin(); it != v2.end(); it++)
		{
			cout << *it<< " ";
		}
		cout << endl;
	}
	cout << "-----------------------" << endl;
	system("pause");
	cout << endl;
}


//比赛
void SpeechManager::speechContest()
{
	cout << "--------------第" << this->m_Index << "轮比赛正式开始！----------------" << endl;
	cout << "评委正在打分！请稍后......" << endl;

	//准备一个临时的容器存放小组成绩

	multimap<double, int, greater<int>>groupScore;//临时容器，保存key分数 value选手编号   multimap允许分数重复

	int num = 0;//记录人员个数,6人为一组
		
	vector<int>v_Src;//比赛选手的容器

	if (this->m_Index == 1)
	{
		v_Src = v1;
	}
	else
	{
		v_Src = v2;
	}
	//遍历所有参赛选手进行比赛
	for (vector<int>::iterator it = v_Src.begin(); it != v_Src.end(); it++)
	{
		num++;
		//评委打分
		deque<double>d;//接收每个人的分数
		for (int i = 0; i < 10; i++)
		{
			double score = (rand() % 401 + 600)/ 10.f;      //600~1000  随机数

			//cout << score << " ";//10个评委具体打分  有异议可以查

			d.push_back(score);
		}
		//cout << endl;

		sort(d.begin(), d.end(), greater<double>());  //排序从大到小

		d.pop_front();  //去除最高分
		d.pop_back();  //去除最低分
		double  sum = accumulate(d.begin(), d.end(), 0.0f);//累加总分
		double avg = sum / (double)d.size();//平均分
		


		//打印每个人的平均分
		
		//cout << "编号：" << *it << "姓名：" << this->m_Speaker[*it].m_Name << "获取平均分：" << avg << endl;  //打印平均分
		
		//将平均分放到map容器中
		this->m_Speaker[*it].m_Score[this->m_Index - 1] = avg;

		//将打分数据 放入临时容器在中..//6人一组，用临时容器保存
		groupScore.insert(make_pair(avg, *it));//key是平均得分，value是具体选手编号 //groupScore小组容器

		Sleep(600);


		//每六人取出前三名

		if (num % 6 == 0)
		{
			cout << "第" << num / 6 << "小组比赛名次：" << endl;
			for (multimap<double, int, greater<double>>::iterator it = groupScore.begin(); it != groupScore.end(); it++)
			{
				cout << "编号：" << it->second << "  姓名：" << this->m_Speaker[it->second].m_Name << "  成绩：" << this->m_Speaker
					[it->second].m_Score[this->m_Index - 1] << endl;
			}

			int count = 0;

			//取走前三名

			for (multimap<double,int,greater<double>>::iterator it = groupScore.begin(); it != groupScore.end()&&count<3; it++,count++)
			{
				if (this->m_Index == 1)
				{
					v2.push_back((*it).second);
				}
				else
				{
					vVictory.push_back((*it).second);
				}
			}
			//取走前三个放入下一个
			groupScore.clear();//小组容器清空
			cout << endl;
		}
		

	}

	cout << "--------------第" << this->m_Index << "轮比赛完毕！----------------" << endl;
	system("pause");
	//cout << endl;
}

//显示得分
void SpeechManager::showScore()
{
	cout << "-------------第" << this->m_Index << "轮晋级选手信息如下：----------------" << endl;

	vector<int>v;

	if (this->m_Index == 1)
	{
		v = v2;
	}
	else
	{
		v = vVictory;
	}
	for (vector<int>::iterator it = v.begin(); it != v.end(); it++)
	{
		cout << "选手编号：" << *it << "  姓名：" << m_Speaker[*it].m_Name << "  得分：" <<m_Speaker[*it].m_Score[this->m_Index - 1] << endl;
	}
	cout << endl;

	system("pause");
	system("cls");
	this->show_Menu();
}
//保存记录
void SpeechManager::saveRecored()
{
	ofstream ofs;
	ofs.open("speech.csv", ios::out | ios::app);//用追加的方式写文件//用输出的方式打开文件   --  写文件

	//将每个选手的数据写入文件中
	for (vector<int>::iterator it = vVictory.begin(); it != vVictory.end(); it++)
	{
		ofs << *it << "," << this->m_Speaker[*it].m_Score[1] << ",";

	}
	ofs << endl;

	//关闭文件
	ofs.close();

	cout << "记录已经保存！" << endl;

	//更改文件不为空状态
	this->fileIsEmpty = false;//有记录了，文件不为空
}


//保存记录
void SpeechManager::loadRecord()
{
	ifstream ifs("speech.csv",ios::in);//输入流对象 读取文件

	if (!ifs.is_open())
	{
		this->fileIsEmpty = true;
		cout << "文件不存在！" << endl;
		ifs.close();
		return;
	}

	//文件清空情况
	char ch;
	ifs >> ch;
	if (ifs.eof())
	{
		cout << "文件为空！"<<endl;
		this->fileIsEmpty = true;
		ifs.close();
		return;
	}

	//文件不为空
	this->fileIsEmpty = false;

	ifs.putback(ch);//将上面读取的单个字符 放回来

	string data;
	int index = 0;

	while (ifs >> data)
	{
		//cout << data << endl;
		//10008,88.9625,10004,86.7,10002,81.125,

		vector<string>v; //为了存放六个string字符串
		int pos = -1; //查到“，”位置的变量
		int start = 0;

		while (true)
		{

			pos = data.find(",", start);//从0开始找
			if (pos == -1)
			{
				break;////未找到情况  break返回
			}
			string temp = data.substr(start, pos - start);   //找到了"，"进行分割 参数1 起始位置，参数2 截取长度
			//cout << temp << endl;
			 v.push_back(temp);
			start = pos + 1;
		}
		this->m_Record.insert(make_pair(index, v));
		index++;
	}
	ifs.close();

	/*for (map<int, vector<string>>::iterator it = this->m_Record.begin(); it != m_Record.end(); it++)
	{
		cout << it->first << "冠军编号：" << it->second[0] << "分数：" << it->second[1] << endl;
	}*/
}


//显示往届记录
void SpeechManager::showRecord()
{
	if (this->fileIsEmpty)
	{
		cout << "文件不存在，或记录为空！" << endl;
	}
	else
	{
		for (int i = 0; i < this->m_Record.size(); i++)
		{
		cout << "第" << i + 1 << "届"
			<< "冠军编号：" << this->m_Record[i][0] <<"\t" << "得分：" << this->m_Record[i][1] << "\t "
			<< "亚军编号：" << this->m_Record[i][2] <<"\t" << "得分：" << this->m_Record[i][3] << "\t "
			<< "季军编号：" << this->m_Record[i][4] <<"\t" << "得分：" << this->m_Record[i][5] << endl;
		}
	}
	system("pause");
	system("cls");
}


//清空文件
void SpeechManager::clearRecord() 
{
	cout << "是否确定清空文件？" << endl;
	cout << "1、确定" << endl;
	cout << "2、返回" << endl;

	int select = 0;
	cin >> select;

	if (select == 1)
	{
		//打开模式 ios::truns如果存在删除文件并重新创建

		ofstream ofs("speech.csv",ios::trunc);//确认清空
		ofs.close();

		//初始化容器和属性
		this->initSpeech();

		//创建12名选手
		this->createSpeaker();

		//加载获取往届记录
		this->loadRecord();

		cout << "清空成功！" << endl;

	}
	system("pause");
	system("cls");

}

//析构函数
SpeechManager::~SpeechManager()
{


>>>>>>> 64b98629441b4b81bfb2bf12d3fa74438f1d4a8e
}