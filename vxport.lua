

-- FUNCTIONS

-- convert an integer to a binary-string
local function int2byn(n, len)
  local str = ""
  for i = len-1, 0 , -1 do
    local tmp = math.floor(n / (256 ^ i))
    if tmp > 255 then
      local tmp2 = math.floor(tmp / 256) * 256
      tmp = tmp - tmp2
    end
    str = str .. string.char(math.floor(tmp))
  end
  return str
end

-- expand each character in a binary-string into hex-pairs
local function byn2hex(byn_str)
  local hex_str = ""
  for i = 1, #byn_str do
    hex_str = hex_str .. string.format("%02X", string.byte(byn_str, i))
  end
  return hex_str
end

-- convert a string of hex-pairs into a binary character string
local function hex2byn(hex_str)
  local byn_str = ""
  for i = 1, #hex_str, 2 do
    local s = hex_str:sub(i, i + 1)
    local c = tonumber(s, 16)
    byn_str = byn_str .. string.char(c)
  end
  return byn_str
end

-- print("hi there smexy!")
-- print(byn2hex("Mthd\0\0\0\6"))
-- print(byn2hex("abcd 999"))
-- print(hex2byn(byn2hex("abcd 999")))
-- print(byn2hex(int2byn(0xFF00FF, 4)))

local function vxport(fpath_str)
  print(fpath_str)
  print("exporting " .. fpath_str)

  local R_SONG = assert(renoise.song(), "no song???")
  local R_INSTRUMENTS = R_SONG.instruments
  local R_TRACKS = R_SONG.tracks
  local R_SEQUENCER = R_SONG.sequencer

  local instrument_lut = table.create()
  for nn = 1, #R_INSTRUMENTS do
    local R_INSTRUMENT_nn = R_INSTRUMENTS[nn]
    instrument_lut[nn]:insert{
      index = nn,
      channel = R_INSTRUMENT_nn.midi_output_properties.channel,
      bank = R_INSTRUMENT_nn.midi_output_properties.bank,
      program = R_INSTRUMENT_nn.midi_output_properties.program
    }
  end

  local track_count = #R_TRACKS
  for ii = 1, #R_TRACKS do
    local pattern_offset = 0
    local note_col_count = R_TRACKS[ii].visible_note_columns

    local sequence_count = #R_SEQUENCER.pattern_sequence
    for jj = 1, sequence_count do
      local pat_jj = R_SEQUENCER.pattern_sequence[jj]
      local R_PATT_jj = R_SONG.patterns[pat_jj]
      local R_PATT_TRACK_ij = R_PATT_jj.tracks[ii]

      local pattern_length = R_PATT_jj.number_of_lines
      for kk = 1, pattern_length do
        local pos = pattern_offset + kk
        local R_PATT_TRACK_LINE_ijk = R_PATT_TRACK_ij:line(kk)

        for mm = 1, note_col_count do
          local R_NOTE_ijkm = R_PATT_TRACK_LINE_ijk.note_columns[mm]

          local nn = R_NOTE_ijkm.instrument_value
          local note_val = R_NOTE_ijkm.note_value < 120
          local instr = instrument_lut[nn]
          if instr and note_val < 120 then
            
          end

        end

      end --kk<pattern_length
      pattern_offset = pattern_offset + pattern_length
    end --jj<sequence_count
  end --ii<track_count
  
  -- primary header
  local frame_tik = 480--FAKE
  local track_num = #R_TRACKS
  local midi_typ = 0
  if track_num > 1 then midi_typ = 1 end
  local mthd_len = 6
  local mid_str = "MThd"
    .. int2byn(mthd_len, 4)
    .. int2byn(midi_typ, 2)
    .. int2byn(track_num, 2)
    .. int2byn(frame_tik, 2)
  print("".. byn2hex(mid_str))

  
end


-- MODULE

local M = {}

function M:export(fpath_str)
  print(fpath_str)
  vxport(fpath_str)
end

return M
