resource MicroResGR = {

param
  Number = Sg | Pl ;
  Case   = Nom | Acc ;
  Gender = Masc | Fem | Neut ;
  Agreement = Agr Gender Number ;
  VForm = Inf | PresSg3 | Past | PastPart | PresPart ;

oper
  -----------------------------------------------------
  -- Nouns
  -----------------------------------------------------
  Noun : Type = {s : Number => Str ; g : Gender} ;

  mkNoun : Str -> Str -> Gender -> Noun = \sg, pl, g -> {
    s = table {Sg => sg ; Pl => pl} ;
    g = g
    } ;

  -- Smart paradigm: 
  smartNoun : Str -> Noun = \sg -> case sg of {
    x + "ί"    => mkNoun sg (x + "ιά") Neut ;
    x + "ό"    => mkNoun sg (x + "ά")  Neut ;
    x + "ο"    => mkNoun sg (x + "α")  Neut ;
    x + "ος"   => mkNoun sg (x + "οι") Masc ;
    x + "ας"   => mkNoun sg (x + "ες") Masc ;
    x + "ής"   => mkNoun sg (x + "ές") Masc ;
    x + ("ά" | "ή")    => mkNoun sg (x + "ές")   Fem ;
    x + ("α" | "η")  => mkNoun sg (x + "ες")   Fem ;
    _          => mkNoun sg (sg + "α")   Neut
    } ;


  -------------------------------------------------------
  -- Adjectives
  -------------------------------------------------------
  Adjective : Type = {s : Gender => Number => Str} ;

  mkAdjective : Str -> Str -> Str -> Adjective = \m, f, n -> {
    s = table {
      Masc => table {
        Sg => m ;
        Pl => case m of {
          x + "ος" => x + "οι" ; 
          x + "ός" => x + "οί" ; 
          x + "ύς" => x + "είς" ; 
          _        => m
          }
        } ;
      Fem  => table {
        Sg => f ;
        Pl => case f of {
          x + ("ή" | "ά" ) => x + "ές" ; 
          x + ("α" | "η")  => x + "ες" ; 
          _                => f
          }
        } ;
      Neut => table {
        Sg => n ;
        Pl => case n of {
          x + "ό"          => x + "ά" ;
          x + "ύ"          => x + "ιά" ;
          x + ("ο" | "υ")  => x + "α" ;
          _                => n
          }
        }
      }
    } ;

  -- Smart paradigm:
  smartAdj : Str -> Adjective = \neut -> case neut of {
    x + "ιό" => mkAdjective (x + "ιός") (x + "ιά") neut ;
    x + "ιο" => mkAdjective (x + "ιος") (x + "ια") neut ;    
    x + "ύ"  => mkAdjective (x + "ύς")  (x + "ιά") neut ;
    x + "ο"  => mkAdjective (x + "ος")  (x + "η")  neut ;
    x + "ό"  => mkAdjective (x + "ός")  (x + "ή")  neut ;
    _        => mkAdjective neut neut neut
    } ;


  -------------------------------------------------------
  -- Verbs
  -------------------------------------------------------
  Verb : Type = {s : VForm => Str} ;

  mkVerb : (pres1sg, pres3sg, past3sg, pastpart, pres3pl : Str) -> Verb
    = \p1, p3, past, pp, pl -> {
    s = table {
      Inf      => p1 ;
      PresSg3  => p3 ;
      Past     => past ;
      PastPart => pp ;
      PresPart => pl
      }
    } ;

  -- Regular verbs with predictable variations
  regVerb : Str -> Verb = \p1 -> case p1 of {
    stem + "αίνω" => mkVerb p1 (stem+"αίνει") (stem + "ε") (stem+"αίνοντας") (stem+"αίνουν") ;
    stem + "ω"    => mkVerb p1 (stem+"ει") ("έ" + stem + "ε") (stem+"μένο") (stem+"ουν") ;
    stem + "ομαι" => mkVerb p1 (stem+"εται") (stem + "θηκε") (stem+"μένο") (stem+"ονται") ;
    stem + "ώ"    => mkVerb p1 (stem+"ά") (stem+"ησε") (stem+"ημένο") (stem+"ούν") ;
    stem + "άμαι" => mkVerb p1 (stem+"άται") (stem+"ήθηκε") (stem+"ισμένο") (stem+"ούνται") ; 
    _             => mkVerb p1 (p1+"ει") (p1+"ε") (p1+"μένο") (p1+"ουν")
    } ;

  -- normal irregular verbs
  irregVerb : (pres1sg, past3sg, pastpart : Str) -> Verb =
    \p1, past, pp ->
      let reg = regVerb p1
      in mkVerb p1 (reg.s ! PresSg3) past pp (reg.s ! PresPart) ;

  Verb2 : Type = Verb ** {c : Str} ;

  be_Verb : Verb = mkVerb "είμαι" "είναι" "ήταν" "ων" "είναι" ;


  -------------------------------------------------------
  -- Agreement helpers
  -------------------------------------------------------
  agr2vform : Agreement -> VForm = \a -> case a of {
    Agr _ Sg => PresSg3 ;
    Agr _ Pl => PresPart 
    } ;

  genderOf : Agreement -> Gender = \a -> case a of {
    Agr g _ => g
    } ;

  numberOf : Agreement -> Number = \a -> case a of {
    Agr _ n => n
  } ;
}
