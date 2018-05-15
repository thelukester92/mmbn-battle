return {
    texture='player.png',
    frames={
        idle={ 98, 4, 34, 45 },
        shoot={ 140, 4, 48, 44 },
        move_1={ 191, 375, 34, 46, 0, -1 },
        move_2={ 232, 373, 34, 48, 0, -4 },
        move_3={ 273, 373, 35, 48, -1, -4 }
    },
    anims={
        move={ 'move_1', 'move_2', 'move_3', 'idle' }
    }
}
