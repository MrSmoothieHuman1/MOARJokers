--- STEAMODDED HEADER
--- MOD_NAME: MOAR Jokers
--- MOD_ID: MJOK
--- MOD_AUTHOR: [Mr.SmoothieHuman]
--- MOD_DESCRIPTION: Adds.. Moar jokers?
--- BADGE_COLOR: c7638f
--- PREFIX: mjok

----------------------------------------------
------------MOD CODE -------------------------

--if see 'self' in balatro code, turn it into 'card' in API code

 --Creates an atlas for cards to use
SMODS.Atlas {
    key = "MoarJokers",
    path = "MoarJokers.png",
    px = 71,
    py = 95
  }
  
  
  SMODS.Joker {
    key = 'x-ray',
    loc_txt = {
      name = 'X-Ray',
      text = {
        "All {C:attention}non-face{} cards played",
        "give {C:mult}+#1#{} Mult"
      }
    },
    config = {extra = {mult = 3}},
    -- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
    -- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
    -- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.mult}}
    end,
    -- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
    rarity = 1,
    unlocked = true,
    discovered = true,
    atlas = 'MoarJokers',
    -- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
    pos = {x = 0, y = 3},
    cost = 4,
    -- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
    calculate = function(self, card, context)
      if context.individual
      and (context.other_card:get_id() == 1 or context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 4 or context.other_card:get_id() == 5 or context.other_card:get_id() == 6 or context.other_card:get_id() == 7 or context.other_card:get_id() == 8 or context.other_card:get_id() == 9 or context.other_card:get_id() == 10 or context.other_card:get_id() == 14)
      and context.cardarea == G.play then
        return {
          mult = card.ability.extra.mult,
                  card = card,
        }
      end
    end
  }
  SMODS.Joker {
    key = 'yang',
    loc_txt = 
    {
      name = 'Yang',
      text = {
        "Retriggers every {C:hearts}Heart{} and {C:diamonds}Diamond{}",
        "card played",
      }
    },
    rarity = 2,
    unlocked = true,
    discovered = false,
    atlas = "MoarJokers",
    pos = {x = 3, y = 2},
    cost = 5,
    config = {extra = {repetitions = 1}},
    blueprint_compat = true,
    calculate = function(self, card, context)
    -- Checks that the current cardarea is G.play, or the cards that have been played, then checks to see if it's time to check for repetition.
    -- The "not context.repetition_only" is there to keep it separate from seals.
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds") then
        return {
          message = 'Again!',
          repetitions = card.ability.extra.repetitions,
          card = card
        }
      end
    end
  end
  }

  SMODS.Joker {
    key = 'yin',
    loc_txt = 
    {
      name = 'Yin',
      text = {
        "Retriggers every {C:spades}Spade{} and {C:clubs}Club{}",
        "card played",
      }
    },
    rarity = 2,
    unlocked = true,
    discovered = false,
    atlas = "MoarJokers",
    pos = {x = 4, y = 2},
    cost = 5,
    blueprint_compat = true,
    config = {extra = {repetitions = 1}},
    calculate = function(self, card, context)
      if context.cardarea == G.play and context.repetition and not context.repetition_only then
        -- context.other_card is something that's used when either context.individual or context.repetition is true
        -- It is each card 1 by 1, but in other cases, you'd need to iterate over the scoring hand to check which cards are there.
        if context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs") then
          return {
            message = 'Again!',
            repetitions = card.ability.extra.repetitions,
            -- The card the repetitions are applying to is context.other_card
            card = card,
          }
        end
      end
  end
  }
  SMODS.Joker{
    key = "high-card-howard",
    loc_txt = 
    {
      name = "High Card Howard",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand is",
        "a {C:attention}High Card{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.15 } },
    rarity = 2,
    atlas = 'MoarJokers',
    pos = {x = 0, y = 1},
    cost = 4,
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and context.scoring_name == 'High Card' and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          -- The return value, "card", is set to the variable "card", which is the joker.
          -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
          -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "pair-pauline",
    loc_txt = 
    {
      name = "Pair Pauline",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Pair{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.25 } },
    rarity = 2,
    atlas = 'MoarJokers',
    pos = {x = 0, y = 0},
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Pair']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          -- The return value, "card", is set to the variable "card", which is the joker.
          -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
          -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "two-pair-theodore",
    loc_txt = 
    {
      name = "Two Pair Theodore",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Two Pair{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.25 } },
    rarity = 2,
    atlas = 'MoarJokers',
    pos = {x = 2, y = 0},
    cost = 5,
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Two Pair']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          -- The return value, "card", is set to the variable "card", which is the joker.
          -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
          -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "three-of-a-kind-tedward",
    loc_txt = 
    {
      name = "Three of a Kind Tedward",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Three of a Kind{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.33 } },
    rarity = 2,
    atlas = 'MoarJokers',
    pos = {x = 1, y = 0},
    cost = 5,
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands["Three of a Kind"]) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          -- The return value, "card", is set to the variable "card", which is the joker.
          -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
          -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "four-of-a-kind-faye",
    loc_txt = 
    {
      name = "Four of aKind Faye",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Four of a Kind{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.44 } },
    rarity = 2,
    atlas = 'MoarJokers',
    pos = {x = 1, y = 1},
    cost = 5,
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Four of a Kind']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          -- The return value, "card", is set to the variable "card", which is the joker.
          -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
          -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "five-of-a-kind-fernando",
    loc_txt = 
    {
      name = "Five of a Kind Fernando",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Five of a Kind{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.55 } },
    rarity = 2,
    atlas = 'MoarJokers',
    pos = {x = 2, y = 1},
    cost = 5,
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Five of a Kind']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          -- The return value, "card", is set to the variable "card", which is the joker.
          -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
          -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "straight-stanley",
    loc_txt = 
    {
      name = "Straight Stanley",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Straight{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.5 } },
    rarity = 3,
    atlas = 'MoarJokers',
    pos = {x = 3, y = 0},
    cost = 5,
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Straight']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          -- The return value, "card", is set to the variable "card", which is the joker.
          -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
          -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "flush-felix",
    loc_txt = 
    {
      name = "Flush Felix",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Flush{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.5 } },
    rarity = 3,
    atlas = 'MoarJokers',
    pos = {x = 4, y = 0},
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Flush']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "straight-flush-steward",
    loc_txt = 
    {
      name = "Straight Flush Steward",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Straight Flush{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.75 } },
    rarity = 3,
    atlas = 'MoarJokers',
    pos = {x = 3, y = 1},
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Straight Flush']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "full-house-felipe",
    loc_txt = 
    {
      name = "Full House Filipe",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "Contains a {C:attention}Full House{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 0.66 } },
    rarity = 3,
    atlas = 'MoarJokers',
    pos = {x = 4, y = 1},
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Full House']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "flush-house-felicity",
    loc_txt = 
    {
      name = "Flush House Felicity",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Flush House{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 1 } },
    rarity = 3,
    atlas = 'MoarJokers',
    pos = {x = 1, y = 2},
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.XMult, card.ability.extra.mult_gain }}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Full House']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      end
    end
  }
  SMODS.Joker{
    key = "flush-five-fabian",
    loc_txt = 
    {
      name = "Flush Five Fabian",
      text = 
      {
        "Gains {X:red,C:white}X#2#{} Mult",
        "if played hand",
        "contains a {C:attention}Flush Five{}",
        "{C:inactive}(Currently {X:red,C:white}X#1#{C:inactive} Mult)"
      }
    },
    config = {extra = { XMult = 1, mult_gain = 1 } },
    rarity = 3,
    atlas = 'MoarJokers',
    pos = {x = 2, y = 2},
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.XMult, card.ability.extra.mult_gain}}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.XMult,
          message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.XMult}}
        }
      end
      if context.before and next(context.poker_hands['Flush Five']) and not context.blueprint then
        card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      end
    end
  }

  SMODS.Joker{
    key = "prime-number-paul",
    loc_txt = 
    {
      name = "Prime Number Paul",
      text = 
      {
        "Played cards that are in the",
        "{C:attention}Prime Number{} set give",
        "{C:mult}+#1#{} mult and {C:chips}+#2#{} chips",
        "{C:inactive}(2, 3, 5, 7, A){}"
      }
    },
    config = {extra = {mult = 5, chips = 11}},
    rarity = 1,
    atlas = "MoarJokers",
    pos = {x = 1, y = 3},
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.mult, card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
      if context.individual
      and (context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 5 or context.other_card:get_id() == 7 or context.other_card:get_id() == 14) then
        return {
          mult = card.ability.extra.mult,
          chips = card.ability.extra.chips,
          card = card,
        }
      end
    end
  }
  SMODS.Joker{
    key = "semiprime-number-saul",
    loc_txt = 
    {
      name = "Semi-Prime Saul",
      text = 
      {
        "Played cards that are in the",
        "{C:attention}Semi Prime's{} set give",
        "{C:mult}+#1#{} mult and {C:chips}+#2#{} chips",
        "{C:inactive}(4, 6, 9, 10){}"
      }
    },
    config = {extra = {mult = 4, chips = 25}},
    rarity = 1,
    atlas = "MoarJokers",
    pos = {x = 2, y = 3},
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.mult, card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
      if context.individual
      and (context.other_card:get_id() == 4 or context.other_card:get_id() == 6 or context.other_card:get_id() == 9 or context.other_card:get_id() == 10) then
        return {
          mult = card.ability.extra.mult,
          chips = card.ability.extra.chips,
          card = card,
        }
      end
    end
  }
  SMODS.Joker {
    key = 'red-onion',
    loc_txt = 
    {
      name = 'Red Onion',
      text = {
        "Gains {C:mult}+#2# Mult{} for",
        "every {C:hearts}Heart{} card played",
        "(~axes at {C:attention}100{})",
        "{C:inactive}(Currently at {C:mult}#1#{} Mult){}"
      }
    },
    rarity = 3,
    unlocked = true,
    discovered = true,
    atlas = "MoarJokers",
    pos = {x = 0, y = 4},
    cost = 5,
    config = {extra = {mult = 0, mult_gain = 1}},
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.mult, card.ability.extra.mult_gain}}
    end,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and not context.blueprint then
      if context.other_card:is_suit("Hearts") then
        card.ability.extra.mult = math.min(card.ability.extra.mult + card.ability.extra.mult_gain, 100)
          return{
            colour = G.C.MULT,
            card = card,
            
          }
      end 
    end
    if context.joker_main then 
        return{
              message = localize{type = "variable", key = "a_mult", vars = {card.ability.extra.mult}},
              mult_mod = card.ability.extra.mult,
      }
    end
  end
  }
  SMODS.Joker {
    key = 'yellow-onion',
    loc_txt = 
    {
      name = 'Yellow Onion',
      text = {
        "Gains {C:money}+$#2#{} for",
        "every {C:diamonds}Diamond{} card played",
        "(Maxes at {C:attention}100{})",
        "{C:inactive}(Currently at {C:monery}$#1#{}){}"
      }
    },
    rarity = 2,
    unlocked = true,
    discovered = true,
    atlas = "MoarJokers",
    pos = {x = 1, y = 4},
    cost = 8,
    config = {extra = {money = 0, money_gain = 0.5}},
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.money, card.ability.extra.money_gain}}
    end,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit("Diamonds") then
        card.ability.extra.money = math.min(card.ability.extra.money + card.ability.extra.money_gain, 100)
        return{
          dollars = card.ability.extra.dollars,
          colour = G.C.MONEY,
          card = card,
        }
        end
      end
    end,
    calc_dollar_bonus = function(self, card)
      local payout = card.ability.extra.money
      if payout > 0 then
        return payout
      end
    end
  }
  SMODS.Joker {
    key = 'blue-onion',
    loc_txt = 
    {
      name = 'Blue Onion',
      text = {
        "Gains {C:chips}+#2# Chips{} for",
        "every {C:clubs}Club{} card played",
        "(Maxes at {C:attention}100{})",
        "{C:inactive}(Currently at {C:chips}#1#{} Chips){}",
      }
    },
    rarity = 1,
    unlocked = true,
    discovered = true,
    atlas = "MoarJokers",
    pos = {x = 2, y = 4},
    cost = 5,
    config = {extra = {chips = 0, chips_gain = 1}},
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.chips, card.ability.extra.chips_gain}}
    end,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and not context.blueprint then
      if context.other_card:is_suit("Clubs") then
        card.ability.extra.chips = math.min(card.ability.extra.chips + card.ability.extra.chips_gain, 100)
          return{
            colour = G.C.CHIPS,
            card = card,
          }
      end 
    end
    if context.joker_main then 
        return{
              message = localize{type = "variable", key = "a_chips", vars = {card.ability.extra.chips}},
              chip_mod = card.ability.extra.chips,
      }
    end
  end
  }
  SMODS.Joker {
    key = 'ice-onion',
    loc_txt = 
    {
      name = 'Ice Onion',
      text = {
        "Gains {C:attention}half{} of the {C:chips}Chips{}",
        "given by every played card",
        "{C:inactive}(Currently {C:chips}+#1#{} Chips){}"
      }
    },
    rarity = 3,
    unlocked = true,
    discovered = false,
    atlas = "MoarJokers",
    pos = {x = 2, y = 5},
    cost = 6,
    config = {extra = {chips = 0}},
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
      return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and not context.blueprint then
      card.ability.extra.chips = card.ability.extra.chips + context.other_card.base.nominal / 2
        return{
          colour = G.C.CHIPS,
          card = card,
          
        }
      end
      if context.joker_main then 
        return{
              message = localize{type = "variable", key = "a_chips", vars = {card.ability.extra.chips}},
              colour = G.C.CHIPS,
              chip_mod = card.ability.extra.chips,
      }
      end
    end
  }
  
