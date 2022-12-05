use std::fs;

fn main() {
    let file_contents =
        fs::read_to_string("input.txt").expect("Should have been able to read the file");

    let stacks: Vec<Vec<char>> = get_current_state(&file_contents);

    let pos = &file_contents
        .lines()
        .position(|x| x.is_empty())
        .unwrap_or_default()
        + 1;
    // println!("{:?}",&stacks);
    let final_state = do_instructions(
        stacks,
        file_contents
            .lines()
            .skip(pos)
            .fold(String::new(), |s, l| s + l + "\n"),
    );
    println!("{:?}", get_answer(&final_state));

    let stacks: Vec<Vec<char>> = get_current_state(&file_contents);
    let final_state = crane9001(
        stacks,
        file_contents
            .lines()
            .skip(pos)
            .fold(String::new(), |s, l| s + l + "\n"),
    );
    println!("{:?}", get_answer(&final_state));
}

fn get_current_state(input: &String) -> Vec<Vec<char>> {
    let pos = input.lines().position(|x| x.is_empty());

    let mut pos = pos.unwrap_or(10) - 1;

    let numofstacks: usize = input
        .lines()
        .nth(pos)
        .unwrap_or_default()
        .split_whitespace()
        .last()
        .unwrap_or_default()
        .parse()
        .expect("wanted number");

    let mut stacks: Vec<Vec<char>> = Vec::new();

    loop {
        pos = pos - 1;
        let mut stack: usize = 0;
        loop {
            let crat = input
                .lines()
                .nth(pos)
                .unwrap_or_default()
                .chars()
                .nth(stack * 4 + 1)
                .unwrap_or_default();
            if stacks.len() <= stack {
                stacks.push(vec![])
            }
            if crat.is_alphabetic() {
                stacks[stack].push(crat);
                // println!("Crate: {}, Stack {}, Position {}", crat, stack, pos);
            }

            if stack == numofstacks - 1 {
                break;
            }
            stack += 1;
        }

        if pos == 0 {
            break;
        }
    }

    return stacks;
}

fn read_instruction(input: &str) -> [usize; 3] {
    return [
        input
            .split_whitespace()
            .nth(1)
            .unwrap_or_default()
            .parse()
            .expect("not a number"),
        input
            .split_whitespace()
            .nth(3)
            .unwrap_or_default()
            .parse()
            .expect("not a number"),
        input
            .split_whitespace()
            .nth(5)
            .unwrap_or_default()
            .parse()
            .expect("not a number"),
    ];
}
fn get_answer(state: &Vec<Vec<char>>) -> String {
    let mut answer: Vec<char> = vec![];
    for v in state {
        if !v.is_empty() {
            let crat = v.last().expect("stack is not empty").to_owned();
            answer.push(crat);
        }
    }
    return answer.iter().collect::<String>();
}

fn do_instructions(mut state: Vec<Vec<char>>, instructions: String) -> Vec<Vec<char>> {
    for instruction in instructions.lines() {
        let instrut = read_instruction(&instruction);
        for _ in 0..instrut[0] {
            if !state[instrut[1] - 1].is_empty() {
                let crat = state[instrut[1] - 1].pop().expect("No more in stack");
                state[instrut[2] - 1].push(crat);
            }
        }
    }
    return state.to_owned();
}

fn crane9001(mut state: Vec<Vec<char>>, instructions: String) -> Vec<Vec<char>> {
    for instruction in instructions.lines() {
        let instrut = read_instruction(&instruction);

        let tomove = state[instrut[1] - 1].len().min(instrut[0]);

        if tomove != 0 {
            let stacksize = state[instrut[1] - 1].len();
            let mut crat = state[instrut[1] - 1].split_off(stacksize - tomove);
            // println!("{},{:?}",tomove,crat);
            state[instrut[2] - 1].append(&mut crat);
        }
    }
    return state.to_owned();
}
