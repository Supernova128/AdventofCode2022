#!/usr/bin/ruby

class Monkey
    def initialize(id,items,op,divisible,iftrue,iffalse)
        @id = id
        @items= items.split(', ').map(&:strip).map(&:to_i)
        @opstr = op
        @divisible = divisible.to_i
        @iftrue = iftrue.strip.to_i
        @iffalse = iffalse.strip.to_i
        @inspected = 0
    end
    def worry_management(worry)
        (worry/3).floor()
    end
    def toss
        if @items.size == 0
            return
        end
        item = @items.shift
        item = op(item)
        item = worry_management(item)
        @inspected += 1
        if item % @divisible == 0
            return @iftrue,item
        else
            return @iffalse,item
        end
    end
    def op(item)
        l = @opstr.split
        if l[0] == 'old'
            x = item
        else
            x = l[0].to_i
        end

        if l[2] == 'old'
            y = item
        else
            y = l[2].to_i
        end
        if l[1] == "*"
            return x*y
        else
            return x+y
    end
    end
    def recieve(item)
        @items.append(item)
        return
    end
    def get_inspected
        @inspected
    end
end


class Hyper_Monkey < Monkey
    def initialize(id,items,op,divisible,iftrue,iffalse,worrym)
        super(id,items,op,divisible,iftrue,iffalse)
        @worrym = worrym
    end
    def worry_management(worry)
        worry % @worrym
    end
end




lines = IO.readlines('input.txt')

$i = 0

monkeys = []

hyper_monkeys = []

worrym = 1

while $i < lines.size
    worrym *= lines[$i+3][21..(lines[$i+3].size - 1)].to_i
    $i += 7
end
$i = 0

while $i < lines.size
    monkeys << Monkey.new(lines[$i][7],
                          lines[$i+1][18..(lines[$i+1].size - 1)],
                          lines[$i+2][19..(lines[$i+2].size - 1)],
                          lines[$i+3][21..(lines[$i+3].size - 1)],
                          lines[$i+4][29..(lines[$i+4].size - 1)],
                          lines[$i+5][30..(lines[$i+5].size - 1)])
    hyper_monkeys << Hyper_Monkey.new(lines[$i][7],
                          lines[$i+1][18..(lines[$i+1].size - 1)],
                          lines[$i+2][19..(lines[$i+2].size - 1)],
                          lines[$i+3][21..(lines[$i+3].size - 1)],
                          lines[$i+4][29..(lines[$i+4].size - 1)],
                          lines[$i+5][30..(lines[$i+5].size - 1)],
                                      worrym)
    $i += 7
end




for $i in (1..20)
    for $j in (0..monkeys.size - 1)
        itemn = monkeys[$j].toss()
        while itemn != nil
            monkeys[itemn[0]].recieve(itemn[1])
            itemn= monkeys[$j].toss()
        end
    end
end

for $i in (1..10000)
    for $j in (0..hyper_monkeys.size - 1)
        itemn = hyper_monkeys[$j].toss()
        while itemn != nil
            hyper_monkeys[itemn[0]].recieve(itemn[1])
            itemn= hyper_monkeys[$j].toss()
        end
    end
end


inspectedls = []

for $j in (0..monkeys.size - 1)
    inspectedls << monkeys[$j].get_inspected
end

inspectedlsh = []

for $j in (0..monkeys.size - 1)
    inspectedlsh << hyper_monkeys[$j].get_inspected
end

print(inspectedls.sort[monkeys.size - 1] * inspectedls.sort[monkeys.size - 2])

print("\n")

print(inspectedlsh.sort[hyper_monkeys.size - 1] * inspectedlsh.sort[hyper_monkeys.size - 2])
print("\n")

