% ucztujący filozowie, filozofowie/0,
% filozowie 0,1,2,3,4
% widelce w0,w1,w2,w3,w4
% filozof x ma widelce wx & w(x+4 mod 5)
filozofowie:-
    mutex_create(W0),
    mutex_create(W4),
    thread_create(filozof_loop(0,W0,W4),_, [detached(true)]),
    mutex_create(W1),
    thread_create(filozof_loop(1,W1,W0),_, [detached(true)]),
    mutex_create(W2),
    thread_create(filozof_loop(2,W2,W1),_, [detached(true)]),
    mutex_create(W3),
    thread_create(filozof_loop(3,W3,W2),_, [detached(true)]),
    thread_create(filozof_loop(4,W4,W3),_, [detached(true)]).





filozof_loop(FILOZOF,RIGHT,LEFT):-
    thinks(FILOZOF,RIGHT,LEFT),
    filozof_loop(FILOZOF,RIGHT,LEFT).


thinks(FILOZOF,RIGHT,LEFT):-
    LEFT \= RIGHT,
    print_task(FILOZOF,'mysli'),
    sleep(3),
    lift_right_fork(FILOZOF,RIGHT,LEFT).

lift_right_fork(FILOZOF,RIGHT,LEFT):-
    print_task(FILOZOF,'chce podniesc prawy widelec'),
    % zablokuj widelec
    mutex_lock(RIGHT),
    print_task(FILOZOF,'podniosl prawy widelec'),
    lift_left_fork(FILOZOF,RIGHT,LEFT).

lift_left_fork(FILOZOF,RIGHT,LEFT):-
    print_task(FILOZOF,'chce podniesc lewy widelec'),
    % zablokuj widelec
    mutex_lock(LEFT),
    print_task(FILOZOF,'podniosl lewy widelec'),
    eats(FILOZOF,RIGHT,LEFT).

eats(FILOZOF,RIGHT,LEFT):-
    print_task(FILOZOF,'je'),
    put_right_fork(FILOZOF,RIGHT,LEFT).

put_right_fork(FILOZOF,RIGHT,LEFT):-
    print_task(FILOZOF,'odkłada prawy widelec'),
    % odblokuj widelec
    mutex_unlock(RIGHT),
    put_left_fork(FILOZOF,RIGHT,LEFT).

put_left_fork(FILOZOF,RIGHT,LEFT):-
    RIGHT \= LEFT,
    print_task(FILOZOF,'odkłada lewy widelec'),
    % odblokuj widelec
    mutex_unlock(LEFT).








% wypisywanie %

print_task(FILOZOF,TASK):-
    print_spaces(FILOZOF),
    write('['),
    write(FILOZOF),
    write(']'),
    write(TASK),
    nl.

print_spaces(0):-!.
print_spaces(FILOZOF):-
    write(' '),
    F1 is FILOZOF-1,
    print_spaces(F1).





