concrete NobelGre of Nobel = LabelsGre ** open
  SyntaxGre,
  ParadigmsGre,
  SymbolicGre,
  LexiconGre
in {

lincat
  Sentence = S ;
  Name = NP ;
  Date = Adv ;

lin
  BornSentence name country date =
    mkS pastTense (mkCl name (mkVP (mkVP (mkVP born_V) (inAdv country)) date)) ;

  AwardSentence name award date =
    mkS pastTense (mkCl name (mkVP (mkVP get_V2 award) date)) ;

  DiedSentence name date =
    mkS pastTense (mkCl name (mkVP (mkVP die_VP) date)) ;

  ------------------------------------------------------------------------------------------------------ 
  -- I purposely left the following commented out code, because currently genders don't work perfectly, 
  -- and I do not know what else to do.. I spent quite some time in this, both with Aarne in the lab
  -- and on my own. Bellow is what commands I tried, most of them get a linearization error, and some 
  -- get a runtime error, prompting me to the issues tab of the repository. 
  -- currently generation always uses "ο" before the names instead of "η" when it is feminine.. "αυτός" & "αυτή" seem to be working though..

  -- FemaleName s = mkNP (<mkPN s.s ** {g=feminine}: PN>) ;
  -- MaleName s = mkNP (<mkPN s.s ** {g=masculine}: PN>) ;
  -- MaleName : Symb -> NP  = \s -> mkNP (mkPN s.s ** {g=masculine}) ;
  -- FemaleName s = mkNP (mkPN s feminine) ;
  -- MaleName s = mkNP (mkPN s masculine) ;

  -- FemaleName s = mkNP (mkPN s.s feminine) ;
  -- MaleName s = mkNP (mkPN s.s masculine) ;
  ------------------------------------------------------------------------------------------------------
  
  FemaleName s = symb s ; -- use if your language needs gender agreement
  MaleName s = symb s ; -- use if your language needs gender agreement
  StringName s = symb s ;

  YearDate i = inAdv <symb i : NP> ;

  he_Name = he_NP ;
  she_Name = she_NP ;
  they_Name = they_NP ;

oper
  inAdv : NP -> Adv = \np -> SyntaxGre.mkAdv in_Prep np ;
  die_VP = die_V ;
  born_V = v_VerbNoPassive "γεννιέμαι"  "γεννυθώ" "γεννήθηκα" "γεννιόμουνα" "γεννήθηκε" "γεννημένος" ;
  get_V2 = dirV2 (v_Verbirreg_pigaInw "παίρνω" "πάω" "πήρα" "έπαιρνα") ;
}
