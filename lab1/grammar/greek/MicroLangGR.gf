--# -path=.:../abstract
concrete MicroLangGR of MicroLang = open MicroResGR in {

-----------------------------------------------------
---------------- Grammar part -----------------------
-----------------------------------------------------
  lincat
    Utt  = {s : Str} ;

    S    = {s : Str} ;
    VP = {verb : Verb ; compl : Agreement => Str} ;
    Comp = {s : Agreement => Str} ;
    AP   = Adjective ;
    CN   = Noun ;
    NP   = {s : Case => Str ; a : Agreement} ;
    Pron = {s : Case => Str ; a : Agreement} ;
    Det  = {s : Gender => Str ; n : Number} ;
    Prep = {s : Str} ;
    V    = Verb ;
    V2   = Verb2 ;
    A    = Adjective ;
    N    = Noun ;
    Adv  = {s : Str} ;

  lin

    -- Utterances
    UttS  s  = s ;
    UttNP np = {s = np.s ! Acc} ;

    -- Sentences
    PredVPS np vp = {
      s = np.s ! Nom ++ vp.verb.s ! agr2vform np.a ++ vp.compl ! np.a
    } ;

    -- Verb phrases
    UseV v = {
      verb  = v ;
      compl = \\_ => []
      } ;

    ComplV2 v2 np = {
      verb  = v2 ;
      compl = \\_ => v2.c ++ np.s ! Acc
      } ;

    UseComp comp = {
      verb  = be_Verb ;
      compl = comp.s
      } ;

    CompAP ap = {
      s = \\a => ap.s ! genderOf a ! numberOf a
    } ;

    AdvVP vp adv = 
      vp ** {compl = \\g => vp.compl ! g ++ adv.s} ;

    -- Noun phrases
    DetCN det cn = {
      s = \\c => det.s ! cn.g ++ cn.s ! det.n ;
      a = Agr cn.g det.n
      } ;

    UsePron p = p ;

    a_Det = {s = table {Masc => "ένας" ; Fem => "μία" ; Neut => "ένα"} ; n = Sg} ;
    aPl_Det = {s = table {Masc => [] ; Fem => [] ; Neut => []} ; n = Pl} ;
    the_Det = {s = table {Masc => "ο" ; Fem => "η" ; Neut => "το"} ; n = Sg} ;
    thePl_Det = {s = table {Masc => "οι" ; Fem => "οι" ; Neut => "τα"} ; n = Pl} ;

    UseN n = n ;

    AdjCN ap cn = {
      s = table {n => ap.s ! cn.g ! n ++ cn.s ! n} ;
      g = cn.g
      } ;

    PositA a = a ;

    PrepNP prep np = {s = prep.s ++ np.s ! Acc} ;

    -- Prepositions 
    in_Prep   = {s = "σε"} ;
    on_Prep   = {s = "σε"} ;
    with_Prep = {s = "με"} ;

    -- Pronouns
    he_Pron = {
      s = table {Nom => "αυτός" ; Acc => "αυτόν"} ;
      a = Agr Masc Sg
      } ;
    she_Pron = {
      s = table {Nom => "αυτή" ; Acc => "αυτήν"} ;
      a = Agr Fem Sg
      } ;
    they_Pron = {
      s = table {Nom => "αυτοί" ; Acc => "αυτούς"} ;
      a = Agr Masc Pl
      } ;

-----------------------------------------------------
---------------- Lexicon part -----------------------
-----------------------------------------------------

-- Adverbs
lin already_Adv   = mkAdv "ήδη" ;
lin now_Adv       = mkAdv "τώρα" ;

-- Nouns
lin animal_N      = mkN "ζώο" Neut ;
lin apple_N       = mkN "μήλο" Neut ;
lin baby_N        = mkN "μωρό" Neut ;
lin beer_N        = mkN "μπύρα" Fem ;
lin bike_N        = mkN "ποδήλατο" Neut ;
lin bird_N        = mkN "πουλί" Neut ;
lin blood_N       = mkN "αίμα" "αίματα" Neut ;
lin boat_N        = mkN "πλοίο" Neut ;
lin book_N        = mkN "βιβλίο" Neut ;
lin boy_N         = mkN "αγόρι" Neut ;
lin bread_N       = mkN "ψωμί" Neut ;
lin car_N         = mkN "αυτοκίνητο" Neut ;
lin cat_N         = mkN "γάτα" Fem ;
lin child_N       = mkN "παιδί" Neut ;
lin city_N        = mkN "πόλη" "πόλεις" Fem;
lin cloud_N       = mkN "σύννεφο" Neut ;
lin computer_N    = mkN "υπολογιστής" Masc ;
lin cow_N         = mkN "αγελάδα" Fem ;
lin dog_N         = mkN "σκύλος" Masc ;
lin fire_N        = mkN "φωτιά" Fem ;
lin fish_N        = mkN "ψάρι" Neut ;
lin flower_N      = mkN "λουλούδι" Neut ;
lin friend_N      = mkN "φίλος" Masc ;
lin girl_N        = mkN "κορίτσι" Neut ;
lin grammar_N     = mkN "γραμματική" Fem ;
lin horse_N       = mkN "άλογο" Neut ;
lin house_N       = mkN "σπίτι" Neut ;
lin language_N    = mkN "γλώσσα" Fem ;
lin man_N         = mkN "άνδρας" Masc ;
lin milk_N        = mkN "γάλα" "γάλατα" Neut ;
lin music_N       = mkN "μουσική" Fem ;
lin river_N       = mkN "ποτάμι" Neut ;
lin sea_N         = mkN "θάλασσα" Fem ;
lin ship_N        = mkN "πλοίο" Fem ;
lin star_N        = mkN "αστέρι" Neut ;
lin train_N       = mkN "τρένο" Neut ;
lin tree_N        = mkN "δέντρο" Neut ;
lin water_N       = mkN "νερό" Neut ;
lin wine_N        = mkN "κρασί" Neut ;
lin woman_N       = mkN "γυναίκα" Fem ;

-- Adjectives
lin bad_A         = mkA "κακό" ;
lin big_A         = mkA "μεγάλο" ;
lin black_A       = mkA "μαύρο" ;
lin blue_A        = mkA "μπλε" ;
lin clean_A       = mkA "καθαρό" ;
lin clever_A      = mkA "έξυπνο" ;
lin cold_A        = mkA "κρύος" "κρύα" "κρύο" ;
lin dirty_A       = mkA "βρόμικο" ;
lin good_A        = mkA "καλό" ;
lin green_A       = mkA "πράσινο" ;
lin heavy_A       = mkA "βαρύ" ; 
lin hot_A         = mkA "ζεστό" ;
lin new_A         = mkA "καινούριο" ;
lin old_A         = mkA "παλιό" ;
lin ready_A       = mkA "έτοιμο" ;
lin red_A         = mkA "κόκκινο" ;
lin small_A       = mkA "μικρό" ;
lin warm_A        = mkA "ζεστό" ;
lin white_A       = mkA "λευκό" ;
lin yellow_A      = mkA "κίτρινο" ;
lin young_A       = mkA "νέος" "νέα" "νέο" ;

-- Intransitive verbs
lin come_V        = mkV "έρχομαι" "ήρθε" "έρχόμενο" ;
lin go_V          = mkV "πηγαίνω";
lin jump_V        = mkV "πηδώ" ;
lin live_V        = mkV "ζω" "έζησε" "ζώντας" ;
lin play_V        = mkV "παίζω" ;
lin run_V         = mkV "τρέχω" ;
lin sleep_V       = mkV "κοιμάμαι" ;
lin swim_V        = mkV "κολυμπώ" "κολύμπησε" "κολυμπημένο" ;
lin travel_V      = mkV "ταξιδεύω" ;
lin walk_V        = mkV "περπατώ" ;

-- Transitive verbs
lin break_V2      = mkV2 (mkV "σπάω" "έσπασε" "σπασμένο") ;
lin buy_V2        = mkV2 (mkV "αγοράζω" "αγόρασε" "αγορασμένο") ;
lin drink_V2      = mkV2 (mkV "πίνω" "ήπιε" "πιωμένο") ;
lin eat_V2        = mkV2 (mkV "τρώω" "έφαγε" "φαγωμένο") ;
lin find_V2       = mkV2 (mkV "βρίσκω") ;
lin kill_V2       = mkV2 (mkV "σκοτώνω" "σκότωσε" "σκοτωμένο") ;
lin love_V2       = mkV2 (mkV "αγαπώ") ;
lin read_V2       = mkV2 (mkV "διαβάζω" "διάβασε" "διαβασμένο") ;
lin see_V2        = mkV2 (mkV "βλέπω" "είδε" "ιδωμένο") ;
lin teach_V2      = mkV2 (mkV "διδάσκω" "δίδαξε" "διδαγμένο") ;
lin understand_V2 = mkV2 (mkV "καταλαβαίνω") ;
lin wait_V2       = mkV2 "περιμένω" "για" ;


---------------------------
-- Paradigms part ---------
---------------------------
oper
  -- Nouns
  mkN = overload {
    mkN : Str -> Gender -> N = \sg, g -> lin N (smartNoun sg g) ; -- Predictable nouns
    mkN : Str -> Str -> Gender -> N = \sg, pl, g -> lin N (mkNoun sg pl g) ; -- Irregular nouns
  } ;
  -- Adjectives
  mkA = overload {
    mkA : Str -> A = \neut -> lin A (smartAdj neut) ; -- Predictable adjectives
    mkA : Str -> Str -> Str -> A = \m, f, n -> lin A (mkAdjective m f n) ; -- Irregular adjectives
    } ;
  -- Intransitive verbs
  mkV = overload {
    mkV : Str -> V = \p1 -> lin V (regVerb p1) ; -- Regular verbs
    mkV : Str -> Str -> Str -> V = \p1, past, pp -> lin V (irregVerb p1 past pp) ; -- Irregular verbs
    } ;
  -- Transitive verbs
  mkV2 = overload {
    mkV2 : V -> V2 = \v -> lin V2 (v ** {c = []}) ; -- Any verb with direct object
    mkV2 : Str -> Str -> V2 = \s, p -> lin V2 (regVerb s ** {c = p}) ; -- Regular verb with preposition
    } ;
  -- Adverbs
  mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;
  -- Prepositions
  mkPrep : Str -> Prep = \s -> lin Prep {s = s} ;


}
