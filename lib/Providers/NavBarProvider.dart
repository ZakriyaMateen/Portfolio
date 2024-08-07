import 'package:flutter/material.dart';

class NavBarProvider extends ChangeNotifier{

  bool _homeHover = false;
  bool _experienceHover = false;
  bool _portfolioHover = false;
  bool _articlesHover = false;
  bool _contactHover = false;


  bool get homeHover => _homeHover;
  bool get experienceHover => _experienceHover;
  bool get portfolioHover => _portfolioHover;
  bool get articlesHover => _articlesHover;
  bool get contactHover => _contactHover;

  List<bool> _portfolioLearnMoreList = [false,false,false];
  List<bool> get portfolioLearnMoreList => _portfolioLearnMoreList;

  void updatePortfolioLearnMoreList(int index){
    for (int i = 0; i < _portfolioLearnMoreList.length; i++) {
      _portfolioLearnMoreList[i] = (i == index);
    }
    notifyListeners();
  }
  void resetPortfolioLearnMoreList(){
    _portfolioLearnMoreList = [false,false,false];
    notifyListeners();
  }
  List<bool> _skillsList = [
    false,false,false,false,false,
    false,false,false,false,false
  ];
  void updateSkillsList(int index){
    for (int i = 0; i < _skillsList.length; i++) {
      _skillsList[i] = (i == index);
    }
    notifyListeners();
  }
  List<bool> get skillsList => _skillsList;
  void resetSkillsList(){
    for (int i = 0; i < _skillsList.length; i++) {
      _skillsList[i] =false;
    }
    notifyListeners();
  }

  void updateHomeHover(bool v){
    _homeHover = v;
    notifyListeners();
  }
  void updateExperienceHover(bool v){
    _experienceHover = v;
    notifyListeners();
  }
  void updatePortfolioHover(bool v){
    _portfolioHover = v;
    notifyListeners();
  }
  void updateArticlesHover(bool v){
    _articlesHover = v;
    notifyListeners();
  }
  void updateContactHover(bool v){
    _contactHover = v;
    notifyListeners();
  }

}