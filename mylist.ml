type 'a my_list =
| Item of ('a * 'a my_list)
| Empty

let cons add chain = Item (add, chain)

let rec length chain =
  let rec loop size = function
  | Empty -> size
  | Item (tete, reste) -> loop (size + 1) reste
  in loop 0 chain

let hd = function
| Empty -> raise (Failure "hd")
| Item (tete, reste) -> tete

let tl = function
| Empty -> raise (Failure "tl")
| Item (tete, reste) -> reste

let rec nth chain = function
  | 0 -> (hd chain)
  | a when a < 0 -> raise (Invalid_argument "List.nth")
  | a when a >= length chain -> raise (Failure "nth")
  | a -> nth (tl chain) (a - 1)

let rev chain =
  let rec loop newListe = function
  | Empty -> newListe
  | Item (tete, reste) -> loop (Item (tete, newListe)) reste
  in loop Empty chain

let append first second =
  let rec loop first second = function
  | 0 -> second
  | n -> loop (tl first) (cons (hd first) second) (n - 1)
  in loop (rev first) (second) (length first)

let rev_append first second =
  let rec loop first second = function
  | 0 -> second
  | n -> loop (tl first) (cons (hd first) second) (n - 1)
  in loop first (second) (length first)

let flatten chain =
  let rec loop newListe = function
  | Empty -> newListe
  | Item (tete, reste) -> loop (append newListe tete) (reste)
  in loop Empty chain

let rec iter fct = function
| Empty -> ()
| Item (tete, reste) ->
begin
  fct tete;
  iter fct reste
end

let rec map fct chain =
  let rec loop newListe = function
  | Empty -> rev newListe
  | Item (tete, reste) -> loop (Item (fct tete, newListe)) reste
  in loop Empty chain

let rec fold_left fct a = function
| Empty -> a
| Item (tete, reste) -> fold_left fct (fct a tete) reste

let rec for_all fct = function
| Empty -> true
| Item (tete, reste) -> (fct tete) && (for_all fct reste)

let rec exists fct = function
| Empty -> false
| Item (tete, reste) -> (fct tete) || exists fct reste

let rec mem nb = function
| Empty -> false
| Item (tete, reste) ->
  if tete = nb then true
  else mem nb reste

let rec mem nb = function
| Empty -> false
| Item (tete, reste) ->
  if tete == nb then true
  else mem nb reste

let filter fct chain =
  let rec loop newListe = function
  | Empty -> rev newListe
  | Item (tete, reste) ->
    if fct tete == true then loop (Item (tete, newListe)) reste
    else loop newListe reste
  in loop Empty chain

let split chain =
  let rec loop (l1, l2) = function
  | Empty -> (l1, l2)
  | Item ((first, second), reste) -> loop (Item(first, l1), Item(second, l2)) reste
  in loop (Empty, Empty) (rev chain)

let combine a_list b_list =
  let rec loop newListe a_list = function
  | Empty -> newListe
  | Item(tete, reste) -> loop (Item((hd a_list, tete), newListe)) (tl a_list) reste
  in loop Empty (rev a_list) (rev b_list)
