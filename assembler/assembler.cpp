#include <bits/stdc++.h>
#include <fstream>
using namespace std;

#define PSUEDO_ADDRESS_LENGTH 26
#define IMM_LENGTH 16
#define SHAMT_LENGTH 5

struct r_format
{
    string opcode;
    string rs;
    string rt;
    string rd;
    string shamt;
    string funct;
};

struct i_format
{
    string opcode;
    string rs;
    string rt;
    string imm;
};

struct j_format
{
    string opcode;
    string psuedo_address;
};

r_format make_r_format(string opcode_, string rs_, string rt_, string rd_, string shamt_, string funct_)
{
    r_format instruction = {opcode_, rs_, rt_, rd_, shamt_, funct_};
    return instruction;
}

i_format make_i_format(string opcode_, string rs_, string rt_, string imm_)
{
    i_format instruction = {opcode_, rs_, rt_, imm_};
    return instruction;
}

j_format make_j_format(string opcode_, string psuedo_address_)
{
    j_format instruction = {opcode_, psuedo_address_};
    return instruction;
}

map<string, string> REGISTERS = {{"$0", "00000"},
                                 {"$ZERO", "00000"},
                                 {"$1", "00001"},
                                 {"$AT", "00001"},
                                 {"$2", "00010"},
                                 {"$V0", "00010"},
                                 {"$3", "00011"},
                                 {"$V1", "00011"},
                                 {"$4", "00100"},
                                 {"$A0", "00100"},
                                 {"$5", "00101"},
                                 {"$A1", "00101"},
                                 {"$6", "00110"},
                                 {"$A2", "00110"},
                                 {"$7", "00111"},
                                 {"$A3", "00111"},
                                 {"$8", "01000"},
                                 {"$T0", "01000"},
                                 {"$9", "01001"},
                                 {"$T1", "01001"},
                                 {"$10", "01010"},
                                 {"$T2", "01010"},
                                 {"$11", "01011"},
                                 {"$T3", "01011"},
                                 {"$12", "01100"},
                                 {"$T4", "01100"},
                                 {"$13", "01101"},
                                 {"$T5", "01101"},
                                 {"$14", "01110"},
                                 {"$T6", "01110"},
                                 {"$15", "01111"},
                                 {"$T7", "01111"},
                                 {"$16", "10000"},
                                 {"$S0", "10000"},
                                 {"$17", "10001"},
                                 {"$S1", "10001"},
                                 {"$18", "10010"},
                                 {"$S2", "10010"},
                                 {"$19", "10011"},
                                 {"$S3", "10011"},
                                 {"$20", "10100"},
                                 {"$S4", "10100"},
                                 {"$21", "10101"},
                                 {"$S5", "10101"},
                                 {"$22", "10110"},
                                 {"$S6", "10110"},
                                 {"$23", "10111"},
                                 {"$S7", "10111"},
                                 {"$24", "11000"},
                                 {"$T8", "11000"},
                                 {"$25", "11001"},
                                 {"$T9", "11001"},
                                 {"$26", "11010"},
                                 {"$K0", "11010"},
                                 {"$27", "11011"},
                                 {"$K1", "11011"},
                                 {"$28", "11100"},
                                 {"$GP", "11100"},
                                 {"$29", "11101"},
                                 {"$SP", "11101"},
                                 {"$30", "11110"},
                                 {"$FP", "11110"},
                                 {"$31", "11111"},
                                 {"$RA", "11111"}};

map<string, r_format> R_TYPE_INSTRUCTIONS_RS_RT_RD = {
    // need rs,rt,rd
    {"ADD", make_r_format("000000", "", "", "", "00000", "100000")},
    {"ADDU", make_r_format("000000", "", "", "", "00000", "100001")},
    {"AND", make_r_format("000000", "", "", "", "00000", "100100")},
    {"NOR", make_r_format("000000", "", "", "", "00000", "100111")},
    {"OR", make_r_format("000000", "", "", "", "00000", "100101")},
    {"SLT", make_r_format("000000", "", "", "", "00000", "101010")},
    {"SLTU", make_r_format("000000", "", "", "", "00000", "101011")},
    {"SUB", make_r_format("000000", "", "", "", "00000", "100010")},
    {"SUBU", make_r_format("000000", "", "", "", "00000", "100011")},
    {"XOR", make_r_format("000000", "", "", "", "00000", "100110")},
    {"SLLV", make_r_format("000000", "", "", "", "00000", "000100")},
    {"SRAV", make_r_format("000000", "", "", "", "00000", "000111")},
    {"MULT", make_r_format("000000", "", "", "", "00000", "011000")},
    {"SRLV", make_r_format("000000", "", "", "", "00000", "000110")}};

map<string, r_format> R_TYPE_INSTRUCTIONS_RT_RD_SA = {
    // need rt,rd,sa
    {"SLL", make_r_format("000000", "00000", "", "", "", "000000")},
    {"SRL", make_r_format("000000", "00000", "", "", "", "000010")},
    {"SRA", make_r_format("000000", "00000", "", "", "", "000011")}};

map<string, r_format> R_TYPE_INSTRUCTIONS_RS_RT = {
    // need rs,rt
    {"DIV", make_r_format("000000", "", "", "00000", "00000", "011010")},
    {"DIVU", make_r_format("000000", "", "", "00000", "00000", "011011")},
    // {"MULT", make_r_format("000000", "", "", "00000", "00000", "011000")},// try to implement it using 3 registers 
    {"MULTU", make_r_format("000000", "", "", "00000", "00000", "011001")}};

map<string, r_format> R_TYPE_INSTRUCTIONS_RD = {
    // need rd
    {"MFHI", make_r_format("000000", "00000", "00000", "", "00000", "010000")},
    {"MFLO", make_r_format("000000", "00000", "00000", "", "00000", "010010")}};

map<string, r_format> R_TYPE_INSTRUCTIONS_RS = {
    // need rs
    {"MTHI", make_r_format("000000", "", "00000", "00000", "00000", "010001")},
    {"MTLO", make_r_format("000000", "", "00000", "00000", "00000", "010011")}};

map<string, i_format> I_TYPE_INSTRUCTIONS_MEM = {
    // memory
    // need rs,rt,offset
    {"LB", make_i_format("100000", "", "", "")},
    {"LBU", make_i_format("100100", "", "", "")},
    {"LH", make_i_format("100001", "", "", "")},
    {"LBU", make_i_format("100101", "", "", "")},
    {"LW", make_i_format("100011", "", "", "")},
    {"SB", make_i_format("101000", "", "", "")},
    {"SH", make_i_format("101001", "", "", "")},
    {"SW", make_i_format("101011", "", "", "")}};

map<string, i_format> I_TYPE_INSTRUCTIONS_BRANCH = {
    // branch
    // need rs,rt,offset
    {"BEQ", make_i_format("000100", "", "", "")},
    {"BNE", make_i_format("001000", "", "", "")}};

map<string, i_format> I_TYPE_INSTRUCTIONS_IMM = {
    // immediate
    // need rs,rt,imm
    // {"ADDI", make_i_format("001000", "", "", "")},
    {"ADDI", make_i_format("001001", "", "", "")},
    {"ANDI", make_i_format("001100", "", "", "")},
    {"ORI", make_i_format("001101", "", "", "")},
    {"SLTI", make_i_format("001010", "", "", "")},
    {"SLTIU", make_i_format("001011", "", "", "")},
    {"XORI", make_i_format("001110", "", "", "")}};

map<string, j_format> J_TYPE_INSTRUCTIONS = {
    // need address
    {"J", make_j_format("000010", "")},
    {"JAL", make_j_format("000011", "")},
};

string do_replace(string const &in, string const &from, string const &to)
{
    return regex_replace(in, regex(from), to);
}

string remove_extra_whitespaces(const string &input)
{
    string output;
    output.clear(); // unless you want to add at the end of existing sring...
    unique_copy(input.begin(), input.end(), back_insert_iterator<string>(output), [](char a, char b)
                { return isspace(a) && isspace(b); });
    return output;
}

vector<string> string_split(const string &str)
{
    vector<string> result;
    istringstream iss(str);
    for (string s; iss >> s;)
        result.push_back(s);
    return result;
}

string parse_line(string s)
{
    try
    {
        transform(s.begin(), s.end(), s.begin(), ::toupper);
        s = do_replace(s, ",", " ");
        s = do_replace(s, "[)]", " ");
        s = do_replace(s, "[(]", " ");
        s = remove_extra_whitespaces(s);
        for (const auto i : J_TYPE_INSTRUCTIONS)
        {
            string search_pattern = "^" + i.first + "\\s";
            if (regex_search(s, regex(search_pattern)))
            {
                vector<string> v = string_split(s);
                if (v.size() != 2)
                {
                    return "-1";
                }
                J_TYPE_INSTRUCTIONS[i.first].psuedo_address = bitset<PSUEDO_ADDRESS_LENGTH>(stol(v[1])).to_string();
                return J_TYPE_INSTRUCTIONS[i.first].opcode + J_TYPE_INSTRUCTIONS[i.first].psuedo_address;
            }
        }
        
        for (const auto i : I_TYPE_INSTRUCTIONS_IMM)
        {
            string search_pattern = "^" + i.first + "\\s";
            if (regex_search(s, regex(search_pattern)))
            {
                vector<string> v = string_split(s);
                if (v.size() != 4)
                {
                    return "-1";
                }
                I_TYPE_INSTRUCTIONS_IMM[i.first].rt = REGISTERS[v[1]];
                I_TYPE_INSTRUCTIONS_IMM[i.first].rs = REGISTERS[v[2]];
                I_TYPE_INSTRUCTIONS_IMM[i.first].imm = bitset<IMM_LENGTH>(stol(v[3])).to_string();
                return I_TYPE_INSTRUCTIONS_IMM[i.first].opcode + I_TYPE_INSTRUCTIONS_IMM[i.first].rs + I_TYPE_INSTRUCTIONS_IMM[i.first].rt + I_TYPE_INSTRUCTIONS_IMM[i.first].imm;
            }
        }

        for (const auto i : I_TYPE_INSTRUCTIONS_MEM)
        {
            string search_pattern = "^" + i.first + "\\s";
            if (regex_search(s, regex(search_pattern)))
            {
                vector<string> v = string_split(s);
                if (v.size() != 4)
                {
                    return "-1";
                }
                I_TYPE_INSTRUCTIONS_MEM[i.first].rt = REGISTERS[v[1]];
                I_TYPE_INSTRUCTIONS_MEM[i.first].imm = bitset<IMM_LENGTH>(stol(v[2])).to_string();
                I_TYPE_INSTRUCTIONS_MEM[i.first].rs = REGISTERS[v[3]];
                return I_TYPE_INSTRUCTIONS_MEM[i.first].opcode + I_TYPE_INSTRUCTIONS_MEM[i.first].rs + I_TYPE_INSTRUCTIONS_MEM[i.first].rt + I_TYPE_INSTRUCTIONS_MEM[i.first].imm;
            }
        }

        for (const auto i : I_TYPE_INSTRUCTIONS_BRANCH)
        {
            string search_pattern = "^" + i.first + "\\s";
            if (regex_search(s, regex(search_pattern)))
            {
                vector<string> v = string_split(s);
                if (v.size() != 4)
                {
                    return "-1";
                }
                I_TYPE_INSTRUCTIONS_BRANCH[i.first].rt = REGISTERS[v[1]];
                I_TYPE_INSTRUCTIONS_BRANCH[i.first].imm = bitset<IMM_LENGTH>(stol(v[3])).to_string();
                I_TYPE_INSTRUCTIONS_BRANCH[i.first].rs = REGISTERS[v[2]];
                return I_TYPE_INSTRUCTIONS_BRANCH[i.first].opcode + I_TYPE_INSTRUCTIONS_BRANCH[i.first].rs + I_TYPE_INSTRUCTIONS_BRANCH[i.first].rt + I_TYPE_INSTRUCTIONS_BRANCH[i.first].imm;
            }
        }

        for (const auto i : R_TYPE_INSTRUCTIONS_RT_RD_SA)
        {
            string search_pattern = "^" + i.first + "\\s";
            if (regex_search(s, regex(search_pattern)))
            {
                vector<string> v = string_split(s);
                if (v.size() != 4)
                {
                    return "-1";
                }
                R_TYPE_INSTRUCTIONS_RT_RD_SA[i.first].rd = REGISTERS[v[1]];
                R_TYPE_INSTRUCTIONS_RT_RD_SA[i.first].rt = REGISTERS[v[2]];
                R_TYPE_INSTRUCTIONS_RT_RD_SA[i.first].shamt = bitset<SHAMT_LENGTH>(stol(v[3])).to_string();
                ;
                return R_TYPE_INSTRUCTIONS_RT_RD_SA[i.first].opcode + R_TYPE_INSTRUCTIONS_RT_RD_SA[i.first].rs + R_TYPE_INSTRUCTIONS_RT_RD_SA[i.first].rt + R_TYPE_INSTRUCTIONS_RT_RD_SA[i.first].rd + R_TYPE_INSTRUCTIONS_RT_RD_SA[i.first].shamt + R_TYPE_INSTRUCTIONS_RT_RD_SA[i.first].funct;
            }
        }

        for (const auto i : R_TYPE_INSTRUCTIONS_RS_RT_RD)
        {
            string search_pattern = "^" + i.first + "\\s";
            if (regex_search(s, regex(search_pattern)))
            {
                vector<string> v = string_split(s);
                if (v.size() != 4)
                {
                    return "-1";
                }
                R_TYPE_INSTRUCTIONS_RS_RT_RD[i.first].rd = REGISTERS[v[1]];
                R_TYPE_INSTRUCTIONS_RS_RT_RD[i.first].rs = REGISTERS[v[2]];
                R_TYPE_INSTRUCTIONS_RS_RT_RD[i.first].rt = REGISTERS[v[3]];
                return R_TYPE_INSTRUCTIONS_RS_RT_RD[i.first].opcode + R_TYPE_INSTRUCTIONS_RS_RT_RD[i.first].rs + R_TYPE_INSTRUCTIONS_RS_RT_RD[i.first].rt + R_TYPE_INSTRUCTIONS_RS_RT_RD[i.first].rd + R_TYPE_INSTRUCTIONS_RS_RT_RD[i.first].shamt + R_TYPE_INSTRUCTIONS_RS_RT_RD[i.first].funct;
            }
        }

        for (const auto i : R_TYPE_INSTRUCTIONS_RS_RT)
        {
            string search_pattern = "^" + i.first + "\\s";
            if (regex_search(s, regex(search_pattern)))
            {
                vector<string> v = string_split(s);
                if (v.size() != 3)
                {
                    return "-1";
                }
                R_TYPE_INSTRUCTIONS_RS_RT[i.first].rs = REGISTERS[v[1]];
                R_TYPE_INSTRUCTIONS_RS_RT[i.first].rt = REGISTERS[v[2]];
                return R_TYPE_INSTRUCTIONS_RS_RT[i.first].opcode + R_TYPE_INSTRUCTIONS_RS_RT[i.first].rs + R_TYPE_INSTRUCTIONS_RS_RT[i.first].rt + R_TYPE_INSTRUCTIONS_RS_RT[i.first].rd + R_TYPE_INSTRUCTIONS_RS_RT[i.first].shamt + R_TYPE_INSTRUCTIONS_RS_RT[i.first].funct;
            }
        }
        for (const auto i : R_TYPE_INSTRUCTIONS_RS)
        {
            string search_pattern = "^" + i.first + "\\s";
            if (regex_search(s, regex(search_pattern)))
            {
                vector<string> v = string_split(s);
                if (v.size() != 2)
                {
                    return "-1";
                }
                R_TYPE_INSTRUCTIONS_RS[i.first].rs = REGISTERS[v[1]];
                return R_TYPE_INSTRUCTIONS_RS[i.first].opcode + R_TYPE_INSTRUCTIONS_RS[i.first].rs + R_TYPE_INSTRUCTIONS_RS[i.first].rt + R_TYPE_INSTRUCTIONS_RS[i.first].rd + R_TYPE_INSTRUCTIONS_RS[i.first].shamt + R_TYPE_INSTRUCTIONS_RS[i.first].funct;
            }
        }
        for (const auto i : R_TYPE_INSTRUCTIONS_RD)
        {
            string search_pattern = "^" + i.first + "\\s";
            if (regex_search(s, regex(search_pattern)))
            {
                vector<string> v = string_split(s);
                if (v.size() != 2)
                {
                    return "-1";
                }
                R_TYPE_INSTRUCTIONS_RD[i.first].rd = REGISTERS[v[1]];
                return R_TYPE_INSTRUCTIONS_RD[i.first].opcode + R_TYPE_INSTRUCTIONS_RD[i.first].rs + R_TYPE_INSTRUCTIONS_RD[i.first].rt + R_TYPE_INSTRUCTIONS_RD[i.first].rd + R_TYPE_INSTRUCTIONS_RD[i.first].shamt + R_TYPE_INSTRUCTIONS_RD[i.first].funct;
            }
        }

        return "-1";
    }
    catch (const std::exception &e)
    {
        std::cout << e.what();
        return "-1";
    }
}

int main()
{
    fstream input;
    fstream output;
    input.open("input.txt", ios::in);
    output.open("instructionMemory.v", ios::out);
    if (!input)
    {
        cout << "Please provide input.txt" << '\n';
        return 0;
    }

    output<<"module instructionMem (rst, PC, instruction);\n\tinput rst;\n\tinput [31:0] PC;\n\toutput [31:0] instruction;\n\n\treg[7:0] instMem[511:0];\n\n\tinitial begin\n";

    int j=0;

    string line;
    while (!input.eof())
    {
        getline(input, line);
        if(line.length()==0) continue;
        cout << line << '\n';

        string parsed_line = parse_line(line);
        if (parsed_line != "-1")
        {
            for(int m=0;m<4;m++){
                output <<"\t\tinstMem["<<j<<"] <= 8'b";
                for(int k=0;k<8;k++){
                    output<<parsed_line[8*m+k];
                }
                output<<";\n";
                j++;
            }
        }
        else
        {
            cout << "Error while processing line : " << line << endl;
            return 0;
        }
    }

    output<<"\tend\n\n\tassign instruction = {instMem[PC], instMem[PC + 1], instMem[PC + 2], instMem[PC+ 3]};\n\nendmodule";
}