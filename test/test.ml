(* SPDX-License-Identifier: AGPL-3.0-or-later *)

let stress () =
  let start = Unix.time () in
  let stop = start +. 3. in
  while Unix.time () < stop do
    ignore (Sys.opaque_identity (1 + 1))
  done

let () =
  let d1 = DomainPC.spawn (fun _ -> stress ()) in
  let d2 = DomainPC.spawn (fun _ -> stress ()) in
  let d3 = DomainPC.spawn (fun _ -> stress ()) in
  let d4 = DomainPC.spawn (fun _ -> stress ()) in
  stress ();
  List.iter DomainPC.join [ d1; d2; d3; d4 ]
