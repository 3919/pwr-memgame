<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="CLK" />
        <signal name="XLXN_11" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13(15:0)" />
        <signal name="XLXN_14(15:0)" />
        <signal name="XLXN_16(7:0)" />
        <signal name="XLXN_17(1:0)" />
        <signal name="XLXN_18" />
        <signal name="XLXN_19(15:0)" />
        <signal name="XLXN_20(7:0)" />
        <signal name="XLXN_21" />
        <signal name="XLXN_22(7:0)" />
        <signal name="XLXN_23" />
        <signal name="XLXN_24(7:0)" />
        <port polarity="Input" name="CLK" />
        <blockdef name="lcg">
            <timestamp>2020-5-8T23:16:57</timestamp>
            <rect width="288" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="352" y="-172" height="24" />
            <line x2="416" y1="-160" y2="-160" x1="352" />
        </blockdef>
        <blockdef name="logic">
            <timestamp>2020-5-8T23:24:47</timestamp>
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="544" y1="-352" y2="-352" x1="480" />
            <line x2="544" y1="-272" y2="-272" x1="480" />
            <rect width="64" x="480" y="-204" height="24" />
            <line x2="544" y1="-192" y2="-192" x1="480" />
            <rect width="64" x="480" y="-124" height="24" />
            <line x2="544" y1="-112" y2="-112" x1="480" />
            <rect width="64" x="480" y="-44" height="24" />
            <line x2="544" y1="-32" y2="-32" x1="480" />
            <rect width="416" x="64" y="-384" height="448" />
        </blockdef>
        <blockdef name="ps2_controller">
            <timestamp>2020-5-9T13:29:58</timestamp>
            <line x2="0" y1="160" y2="160" x1="64" />
            <rect width="64" x="400" y="20" height="24" />
            <line x2="464" y1="32" y2="32" x1="400" />
            <rect width="64" x="400" y="84" height="24" />
            <line x2="464" y1="96" y2="96" x1="400" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="464" y1="-352" y2="-352" x1="400" />
            <rect width="336" x="64" y="-384" height="576" />
        </blockdef>
        <blockdef name="vga_driver">
            <timestamp>2020-5-9T13:15:21</timestamp>
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="512" y1="32" y2="32" x1="448" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="512" y1="-352" y2="-352" x1="448" />
            <line x2="512" y1="-256" y2="-256" x1="448" />
            <rect width="64" x="448" y="-172" height="24" />
            <line x2="512" y1="-160" y2="-160" x1="448" />
            <rect width="64" x="448" y="-76" height="24" />
            <line x2="512" y1="-64" y2="-64" x1="448" />
            <rect width="384" x="64" y="-384" height="448" />
        </blockdef>
        <blockdef name="counter">
            <timestamp>2020-5-9T13:28:39</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <block symbolname="lcg" name="XLXI_1">
            <blockpin name="i_generate" />
            <blockpin name="i_reset" />
            <blockpin signalname="XLXN_22(7:0)" name="i_seed(7:0)" />
            <blockpin signalname="XLXN_20(7:0)" name="o_random(7:0)" />
        </block>
        <block symbolname="logic" name="XLXI_2">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_21" name="ps2_irq_in" />
            <blockpin signalname="XLXN_12" name="vga_work" />
            <blockpin signalname="XLXN_20(7:0)" name="i_random(7:0)" />
            <blockpin signalname="XLXN_13(15:0)" name="ps2_x(15:0)" />
            <blockpin signalname="XLXN_14(15:0)" name="ps2_y(15:0)" />
            <blockpin signalname="XLXN_19(15:0)" name="vga_address(15:0)" />
            <blockpin signalname="XLXN_23" name="ps2_irq_out" />
            <blockpin signalname="XLXN_18" name="vga_enable" />
            <blockpin signalname="XLXN_16(7:0)" name="vga_datain(7:0)" />
            <blockpin signalname="XLXN_17(1:0)" name="vga_mode(1:0)" />
            <blockpin signalname="XLXN_24(7:0)" name="vga_mouse_pos(7:0)" />
        </block>
        <block symbolname="ps2_controller" name="XLXI_3">
            <blockpin signalname="CLK" name="clk" />
            <blockpin name="dataready" />
            <blockpin signalname="XLXN_21" name="logic_irq" />
            <blockpin name="B1_status(7:0)" />
            <blockpin name="B2_X(7:0)" />
            <blockpin name="B3_Y(7:0)" />
            <blockpin signalname="XLXN_23" name="mouse_irq" />
            <blockpin signalname="XLXN_13(15:0)" name="mouse_x(15:0)" />
            <blockpin signalname="XLXN_14(15:0)" name="mouse_y(15:0)" />
        </block>
        <block symbolname="vga_driver" name="XLXI_4">
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="XLXN_18" name="enable" />
            <blockpin name="vga_busy" />
            <blockpin signalname="XLXN_17(1:0)" name="mode(1:0)" />
            <blockpin signalname="XLXN_16(7:0)" name="mem_datain(7:0)" />
            <blockpin signalname="XLXN_12" name="work" />
            <blockpin name="vga_we" />
            <blockpin signalname="XLXN_19(15:0)" name="mem_address(15:0)" />
            <blockpin name="vga_data(7:0)" />
            <blockpin signalname="XLXN_24(7:0)" name="mouse_pos(15:0)" />
            <blockpin name="vga_reset" />
        </block>
        <block symbolname="counter" name="XLXI_5">
            <blockpin signalname="CLK" name="clk" />
            <blockpin name="reset" />
            <blockpin signalname="XLXN_22(7:0)" name="ticks(7:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1248" y="416" name="XLXI_1" orien="R0">
        </instance>
        <branch name="CLK">
            <wire x2="496" y1="112" y2="224" x1="496" />
            <wire x2="496" y1="224" y2="496" x1="496" />
            <wire x2="2112" y1="496" y2="496" x1="496" />
            <wire x2="2112" y1="496" y2="1120" x1="2112" />
            <wire x2="2128" y1="1120" y2="1120" x1="2112" />
            <wire x2="496" y1="496" y2="528" x1="496" />
            <wire x2="1824" y1="528" y2="528" x1="496" />
            <wire x2="1824" y1="528" y2="640" x1="1824" />
            <wire x2="496" y1="528" y2="1184" x1="496" />
            <wire x2="1216" y1="1184" y2="1184" x1="496" />
            <wire x2="736" y1="224" y2="224" x1="496" />
            <wire x2="1824" y1="640" y2="640" x1="1744" />
        </branch>
        <instance x="1744" y="992" name="XLXI_2" orien="M0">
        </instance>
        <instance x="1216" y="1536" name="XLXI_4" orien="R0">
        </instance>
        <instance x="736" y="320" name="XLXI_5" orien="R0">
        </instance>
        <branch name="XLXN_12">
            <wire x2="1776" y1="1184" y2="1184" x1="1728" />
            <wire x2="1776" y1="768" y2="768" x1="1744" />
            <wire x2="1776" y1="768" y2="1184" x1="1776" />
        </branch>
        <branch name="XLXN_13(15:0)">
            <wire x2="2000" y1="832" y2="832" x1="1744" />
            <wire x2="2000" y1="832" y2="1184" x1="2000" />
            <wire x2="2816" y1="1184" y2="1184" x1="2000" />
            <wire x2="2816" y1="992" y2="992" x1="2592" />
            <wire x2="2816" y1="992" y2="1184" x1="2816" />
        </branch>
        <branch name="XLXN_14(15:0)">
            <wire x2="1952" y1="896" y2="896" x1="1744" />
            <wire x2="1952" y1="896" y2="1232" x1="1952" />
            <wire x2="2608" y1="1232" y2="1232" x1="1952" />
            <wire x2="2608" y1="1056" y2="1056" x1="2592" />
            <wire x2="2608" y1="1056" y2="1232" x1="2608" />
        </branch>
        <branch name="XLXN_16(7:0)">
            <wire x2="1200" y1="800" y2="800" x1="1184" />
            <wire x2="1184" y1="800" y2="1440" x1="1184" />
            <wire x2="1216" y1="1440" y2="1440" x1="1184" />
        </branch>
        <branch name="XLXN_17(1:0)">
            <wire x2="1200" y1="880" y2="880" x1="1168" />
            <wire x2="1168" y1="880" y2="1376" x1="1168" />
            <wire x2="1216" y1="1376" y2="1376" x1="1168" />
        </branch>
        <branch name="XLXN_18">
            <wire x2="1200" y1="720" y2="720" x1="1152" />
            <wire x2="1152" y1="720" y2="1248" x1="1152" />
            <wire x2="1216" y1="1248" y2="1248" x1="1152" />
        </branch>
        <branch name="XLXN_19(15:0)">
            <wire x2="1792" y1="1376" y2="1376" x1="1728" />
            <wire x2="1792" y1="960" y2="960" x1="1744" />
            <wire x2="1792" y1="960" y2="1376" x1="1792" />
        </branch>
        <iomarker fontsize="28" x="496" y="112" name="CLK" orien="R270" />
        <instance x="2128" y="960" name="XLXI_3" orien="R0">
        </instance>
        <branch name="XLXN_20(7:0)">
            <wire x2="1904" y1="256" y2="256" x1="1664" />
            <wire x2="1904" y1="256" y2="1024" x1="1904" />
            <wire x2="1904" y1="1024" y2="1024" x1="1744" />
        </branch>
        <branch name="XLXN_21">
            <wire x2="1760" y1="704" y2="704" x1="1744" />
            <wire x2="1760" y1="704" y2="736" x1="1760" />
            <wire x2="2128" y1="736" y2="736" x1="1760" />
        </branch>
        <branch name="XLXN_22(7:0)">
            <wire x2="1184" y1="224" y2="224" x1="1120" />
            <wire x2="1184" y1="224" y2="384" x1="1184" />
            <wire x2="1248" y1="384" y2="384" x1="1184" />
        </branch>
        <branch name="XLXN_23">
            <wire x2="2656" y1="448" y2="448" x1="1120" />
            <wire x2="2656" y1="448" y2="608" x1="2656" />
            <wire x2="1120" y1="448" y2="640" x1="1120" />
            <wire x2="1200" y1="640" y2="640" x1="1120" />
            <wire x2="2656" y1="608" y2="608" x1="2592" />
        </branch>
        <branch name="XLXN_24(7:0)">
            <wire x2="1200" y1="960" y2="960" x1="1136" />
            <wire x2="1136" y1="960" y2="1568" x1="1136" />
            <wire x2="1216" y1="1568" y2="1568" x1="1136" />
        </branch>
    </sheet>
</drawing>
