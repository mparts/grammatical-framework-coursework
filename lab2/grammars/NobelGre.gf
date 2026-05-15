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
    mkS pastTense (mkCl name (mkVP (mkVP born_V (inAdv country)) date)) ;

  AwardSentence name award date =
    mkS pastTense (mkCl name (mkVP (mkVP get_V award) date)) ;

  DiedSentence name date =
    mkS pastTense (mkCl name (mkVP die_VP date)) ;

  -- FemaleName s = symb s ; -- use if your language needs gender agreement
  -- MaleName s = symb s ; -- use if your language needs gender agreement
  -- FemaleName s = mkNP (<mkPN s.s ** {g=feminine}: PN>) ;
  -- MaleName s = mkNP (<mkPN s.s ** {g=masculine}: PN>) ;
  -- MaleName : Symb -> NP  = \s -> mkNP (mkPN s.s ** {g=masculine}) ;

  FemaleName s = mkNP (mkPN s.s feminine) ;
  MaleName s = mkNP (mkPN s.s masculine) ;


  StringName s = symb s ;

  YearDate i = inAdv <symb i : NP> ;

  he_Name = he_NP ;
  she_Name = she_NP ;
  they_Name = they_NP ;

oper
  inAdv : NP -> Adv = \np -> SyntaxGre.mkAdv in_Prep np ;
  die_VP = die_V ;
  born_V = v_VerbNoPassive "γενιέμαι"  "γενυθώ" "γενήθηκα" "γενιόμουνα" "γενήθηκε" "γενημένος" ;
  get_V = v_Verbirreg_pigaInw "παίρνω" "πάω" "πήρα" "έπαιρνα" ;
}
