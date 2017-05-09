#!/usr/bin/perl
# Kamaljit Chahal, for Zoltan 5/6
use strict;
use warnings;
use diagnostics;
use feature 'say';
use Spreadsheet::Read qw(ReadData rows);
use List::Util qw( min max );

my $book = ReadData ('180IR002.xlsx');
my @rows = rows($book->[1]); #fetch all rows in sheet 1

#display all rows
foreach my $i (1 .. scalar @rows) {
  foreach my $j (1 .. scalar @{$rows[$i-1]}) {
    print ($rows[$i-1][$j-1] // '');
    print "\t";
  }
  print "\n";
}

my $filename = "xmlByKamaljit.xml";

open(my $OUTFILE, '>', $filename) or die "Could not open file '$filename' $!";

my $initial_info = qq{<?xml version="1.0" encoding="utf-8"?>\n<!--(C) Kuka Roboter GmbH 2017-->\n<!--Creation Date: 4/19/2017 12:34:13 PM-->};
# there is a Schema specified as an attribute in the root element but it may not be necessary for this xml to be usable
my $root = qq{<configuration xsi:noNamespaceSchemaLocation="file:///C:/Program Files (x86)/KUKA/WorkVisual 4.0/Schemes/SafetyConfigImport.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">};
my $schema_version = "1.0";
my $controller_type = "KRC4";
my $firmware_version = "8.2.17";
#my @cell_space = ($book->[1]{B3},$book->[1]{C3},$book->[1]{D3},$book->[1]{E3},$book->[1]{F3},$book->[1]{G3});
#my $cs1_X = $book->[1]{cell}[2][3];
my @cellSpace_array = (
		{
		X => $book->[1]{B3},
		Y => $book->[1]{C3},
		Z => $book->[1]{D3},
		RX => $book->[1]{E3},
		RY => $book->[1]{F3},
		RZ => $book->[1]{G3}
		},
		{
		X => $book->[1]{B4},
		Y => $book->[1]{C4},
		Z => $book->[1]{D4},
		RX => $book->[1]{E4},
		RY => $book->[1]{F4},
		RZ => $book->[1]{G4}
		},
		{
		X => $book->[1]{B5},
		Y => $book->[1]{C5},
		Z => $book->[1]{D5},
		RX => $book->[1]{E5},
		RY => $book->[1]{F5},
		RZ => $book->[1]{G5}
		},
		{
		X => $book->[1]{B6},
		Y => $book->[1]{C6},
		Z => $book->[1]{D6},
		RX => $book->[1]{E6},
		RY => $book->[1]{F6},
		RZ => $book->[1]{G6}
		}
	);
	
my @z_numbers = @{$book->[1]{cell}[4]}; # Z column contains the unwanted letter 'Z' as a heading
splice @z_numbers, 0,2; # remove 'Z'
@z_numbers = grep { $_ ne ' ' } @z_numbers;
my $z_min = min @z_numbers;
my $z_max = max @z_numbers;

my @workspaceMonitoring_array = (
		{ # st1_200td001
		X => $book->[1]{B9},
		Y => $book->[1]{C9},
		Z => $book->[1]{D9},
		RX => $book->[1]{E9},
		RY => $book->[1]{F9},
		RZ => $book->[1]{G9}
		},
		{ 
		X => $book->[1]{B10},
		Y => $book->[1]{C10},
		Z => $book->[1]{D10},
		RX => $book->[1]{E10},
		RY => $book->[1]{F10},
		RZ => $book->[1]{G10}
		},
		{ # st1_200td002
		X => $book->[1]{B12},
		Y => $book->[1]{C12},
		Z => $book->[1]{D12},
		RX => $book->[1]{E12},
		RY => $book->[1]{F12},
		RZ => $book->[1]{G12}
		},
		{ 
		X => $book->[1]{B13},
		Y => $book->[1]{C13},
		Z => $book->[1]{D13},
		RX => $book->[1]{E13},
		RY => $book->[1]{F13},
		RZ => $book->[1]{G13}
		},
		{ # st1_200td003
		X => $book->[1]{B15},
		Y => $book->[1]{C15},
		Z => $book->[1]{D15},
		RX => $book->[1]{E15},
		RY => $book->[1]{F15},
		RZ => $book->[1]{G15}
		},
		{
		X => $book->[1]{B16},
		Y => $book->[1]{C16},
		Z => $book->[1]{D16},
		RX => $book->[1]{E16},
		RY => $book->[1]{F16},
		RZ => $book->[1]{G16}
		},
		{ # st1_200td004
		X => $book->[1]{B18},
		Y => $book->[1]{C18},
		Z => $book->[1]{D18},
		RX => $book->[1]{E18},
		RY => $book->[1]{F18},
		RZ => $book->[1]{G18}
		},
		{
		X => $book->[1]{B19},
		Y => $book->[1]{C19},
		Z => $book->[1]{D19},
		RX => $book->[1]{E19},
		RY => $book->[1]{F19},
		RZ => $book->[1]{G19}
		},
		{ # st16_always_active
		X => $book->[1]{B21},
		Y => $book->[1]{C21},
		Z => $book->[1]{D21},
		RX => $book->[1]{E21},
		RY => $book->[1]{F21},
		RZ => $book->[1]{G21}
		},
                { 
		X => $book->[1]{B22},
		Y => $book->[1]{C22},
		Z => $book->[1]{D22},
		RX => $book->[1]{E22},
		RY => $book->[1]{F22},
		RZ => $book->[1]{G22}
		}
	);
	
my @tool_array = (
		{ # tool 1, 180ir002_gr01
		X => $book->[1]{B25},
		Y => $book->[1]{C25},
		Z => $book->[1]{D25},
		RX => $book->[1]{E25},
		RY => $book->[1]{F25},
		RZ => $book->[1]{G25}
		},
		{ 
		X => $book->[1]{B26},
		Y => $book->[1]{C26},
		Z => $book->[1]{D26},
		RX => $book->[1]{E26},
		RY => $book->[1]{F26},
		RZ => $book->[1]{G26}
		},
		{ 
		X => $book->[1]{B27},
		Y => $book->[1]{C27},
		Z => $book->[1]{D27},
		RX => $book->[1]{E27},
		RY => $book->[1]{F27},
		RZ => $book->[1]{G27}
		},
		{ 
		X => $book->[1]{B28},
		Y => $book->[1]{C28},
		Z => $book->[1]{D28},
		RX => $book->[1]{E28},
		RY => $book->[1]{F28},
		RZ => $book->[1]{G28}
		},
		{ # tool 2, 180ir002_gr02
		X => $book->[1]{B31},
		Y => $book->[1]{C31},
		Z => $book->[1]{D31},
		RX => $book->[1]{E31},
		RY => $book->[1]{F31},
		RZ => $book->[1]{G31}
		},
		{ 
		X => $book->[1]{B32},
		Y => $book->[1]{C32},
		Z => $book->[1]{D32},
		RX => $book->[1]{E32},
		RY => $book->[1]{F32},
		RZ => $book->[1]{G32}
		},
		{ 
		X => $book->[1]{B33},
		Y => $book->[1]{C33},
		Z => $book->[1]{D33},
		RX => $book->[1]{E33},
		RY => $book->[1]{F33},
		RZ => $book->[1]{G33}
		},
		{ 
		X => $book->[1]{B34},
		Y => $book->[1]{C34},
		Z => $book->[1]{D34},
		RX => $book->[1]{E34},
		RY => $book->[1]{F34},
		RZ => $book->[1]{G34}
		}
	);
my $xml = qq{$initial_info
$root
  <SchemaVersion>$schema_version</SchemaVersion>
  <ControllerInformation>
    <ControllerType>$controller_type</ControllerType>
    <FirmwareVersion>$firmware_version</FirmwareVersion>
    <KukaOptionPackages>
      <KukaOptionPackage Identifier="DAI_BASEPROJECT" MinVersion="2.3.1.2" />
      <KukaOptionPackage Identifier="DAI_TOOLCHANGE" MinVersion="1.1.8.10" />
      <KukaOptionPackage Identifier="SafeOperation" MinVersion="3.1" />
    </KukaOptionPackages>
  </ControllerInformation>
  <KUKARoboter.SafeRobot.Parameters>
    <encryptedData>
      <SafetyParameters>
        <RangeMonitoring>
          <CellSpace>
            <Zmin>$z_min</Zmin>
            <Zmax>$z_max</Zmax>
            <Polygon Number="1">
              <X>$cellSpace_array[0]->{X}</X>
              <Y>$cellSpace_array[0]->{Y}</Y>
              <IsPolygonNodeActive>1</IsPolygonNodeActive>
            </Polygon>
            <Polygon Number="2">
              <X>$cellSpace_array[1]->{X}</X>
              <Y>$cellSpace_array[1]->{Y}</Y>
              <IsPolygonNodeActive>1</IsPolygonNodeActive>
            </Polygon>
            <Polygon Number="3">
              <X>$cellSpace_array[2]->{X}</X>
              <Y>$cellSpace_array[2]->{Y}</Y>
              <IsPolygonNodeActive>1</IsPolygonNodeActive>
            </Polygon>
            <Polygon Number="4">
              <X>$cellSpace_array[3]->{X}</X>
              <Y>$cellSpace_array[3]->{Y}</Y>
              <IsPolygonNodeActive>1</IsPolygonNodeActive>
            </Polygon>
            <Polygon Number="5">
              <X>0</X>
              <Y>0</Y>
              <IsPolygonNodeActive>0</IsPolygonNodeActive>
            </Polygon>
            <Polygon Number="6">
              <X>0</X>
              <Y>0</Y>
              <IsPolygonNodeActive>0</IsPolygonNodeActive>
            </Polygon>
            <Polygon Number="7">
              <X>0</X>
              <Y>0</Y>
              <IsPolygonNodeActive>0</IsPolygonNodeActive>
            </Polygon>
            <Polygon Number="8">
              <X>0</X>
              <Y>0</Y>
              <IsPolygonNodeActive>0</IsPolygonNodeActive>
            </Polygon>
            <Polygon Number="9">
              <X>0</X>
              <Y>0</Y>
              <IsPolygonNodeActive>0</IsPolygonNodeActive>
            </Polygon>
            <Polygon Number="10">
              <X>0</X>
              <Y>0</Y>
              <IsPolygonNodeActive>0</IsPolygonNodeActive>
            </Polygon>
          </CellSpace>
          <WorkspaceMonitoring Number="1" Name="st1_200td001">
            <Activation>50</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>1</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>$workspaceMonitoring_array[1]->{X}</X>
              <Y>$workspaceMonitoring_array[1]->{Y}</Y>
              <Z>$workspaceMonitoring_array[1]->{Z}</Z>
              <A>$workspaceMonitoring_array[1]->{RZ}</A>
              <B>$workspaceMonitoring_array[1]->{RX}</B> <!--Should this be RX or RY?-->
              <C>$workspaceMonitoring_array[1]->{RY}</C> <!--Should this be RX or RY?-->
              <X1>0</X1>
              <X2>2700</X2>
              <Y1>0</Y1>
              <Y2>2450</Y2>
              <Z1>0</Z1>
              <Z2>05000</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="2" Name="st2_200td002">
            <Activation>50</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>1</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>$workspaceMonitoring_array[3]->{X}</X>
              <Y>$workspaceMonitoring_array[3]->{Y}</Y>
              <Z>$workspaceMonitoring_array[3]->{Z}</Z>
              <A>$workspaceMonitoring_array[2]->{RZ}</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>2700</X2>
              <Y1>0</Y1>
              <Y2>2640</Y2>
              <Z1>0</Z1>
              <Z2>5000</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="3" Name="st3_200td003">
            <Activation>50</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>1</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>$workspaceMonitoring_array[5]->{X}</X>
              <Y>$workspaceMonitoring_array[5]->{Y}</Y>
              <Z>$workspaceMonitoring_array[5]->{Z}</Z>
              <A>$workspaceMonitoring_array[5]->{RZ}</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>2700</X2>
              <Y1>0</Y1>
              <Y2>2620</Y2>
              <Z1>0</Z1>
              <Z2>5000</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="4" Name="st4_200td004">
            <Activation>50</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>1</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>$workspaceMonitoring_array[6]->{X}</X>
              <Y>$workspaceMonitoring_array[6]->{Y}</Y>
              <Z>$workspaceMonitoring_array[6]->{Z}</Z>
              <A>$workspaceMonitoring_array[6]->{RZ}</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>2700</X2>
              <Y1>0</Y1>
              <Y2>2450</Y2>
              <Z1>0</Z1>
              <Z2>5000</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="5" Name="st16_cell">
            <Activation>0</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>1</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>$workspaceMonitoring_array[8]->{X}</X>
              <Y>$workspaceMonitoring_array[8]->{Y}</Y>
              <Z>$workspaceMonitoring_array[8]->{Z}</Z>
              <A>$workspaceMonitoring_array[8]->{RZ}</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>4900</X2>
              <Y1>0</Y1>
              <Y2>1800</Y2>
              <Z1>0</Z1>
              <Z2>5000</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="6" Name="Space 6">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="7" Name="Space 7">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="8" Name="Space 8">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="9" Name="Space 9">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="10" Name="Space 10">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="11" Name="Space 11">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="12" Name="Space 12">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="13" Name="Space 13">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="14" Name="Space 14">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="15" Name="Space 15">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
          <WorkspaceMonitoring Number="16" Name="Space 16">
            <Activation>255</Activation>
            <RobotStops>1</RobotStops>
            <RangeType>1</RangeType>
            <IsProtectedSpace>0</IsProtectedSpace>
            <MonitoringStop>0</MonitoringStop>
            <CheckCartesianSpeedInProtectedArea>0</CheckCartesianSpeedInProtectedArea>
            <CartVel>30000</CartVel>
            <ReferenceRobRoot>0</ReferenceRobRoot>
            <AxisRange>
              <Axis Number="1">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="2">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="3">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="4">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="5">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="6">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-360</AxisLowerBound>
                <AxisUpperBound>360</AxisUpperBound>
              </Axis>
              <Axis Number="7">
                <AxisEnabled>0</AxisEnabled>
                <AxisLowerBound>-30000</AxisLowerBound>
                <AxisUpperBound>30000</AxisUpperBound>
              </Axis>
            </AxisRange>
            <CartesianRange>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <A>0</A>
              <B>0</B>
              <C>0</C>
              <X1>0</X1>
              <X2>0</X2>
              <Y1>0</Y1>
              <Y2>0</Y2>
              <Z1>0</Z1>
              <Z2>0</Z2>
            </CartesianRange>
          </WorkspaceMonitoring>
        </RangeMonitoring>
        <Tools>
          <Tool Number="1" Name="180ir002_gr01">
            <ToolEnabled>1</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>$tool_array[0]->{X}</X>
              <Y>$tool_array[0]->{Y}</Y>
              <Z>$tool_array[0]->{Z}</Z>
              <Radius>600</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>1</SphereEnabled>
              <X>$tool_array[1]->{X}</X>
              <Y>$tool_array[1]->{Y}</Y>
              <Z>$tool_array[1]->{Z}</Z>
              <Radius>600</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>1</SphereEnabled>
              <X>$tool_array[2]->{X}</X>
              <Y>$tool_array[2]->{Y}</Y>
              <Z>$tool_array[2]->{Z}</Z>
              <Radius>600</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>1</SphereEnabled>
              <X>$tool_array[3]->{X}</X>
              <Y>$tool_array[3]->{Y}</Y>
              <Z>$tool_array[3]->{Z}</Z>
              <Radius>600</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="2" Name="180ir002_gr02">
            <ToolEnabled>1</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>$tool_array[4]->{X}</X>
              <Y>$tool_array[4]->{Y}</Y>
              <Z>$tool_array[4]->{Z}</Z>
              <Radius>600</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>1</SphereEnabled>
              <X>$tool_array[5]->{X}</X>
              <Y>$tool_array[5]->{Y}</Y>
              <Z>$tool_array[5]->{Z}</Z>
              <Radius>600</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>1</SphereEnabled>
              <X>$tool_array[6]->{X}</X>
              <Y>$tool_array[6]->{Y}</Y>
              <Z>$tool_array[6]->{Z}</Z>
              <Radius>600</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>1</SphereEnabled>
              <X>$tool_array[7]->{X}</X>
              <Y>$tool_array[7]->{Y}</Y>
              <Z>$tool_array[7]->{Z}</Z>
              <Radius>600</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="3" Name="Tool 3">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="4" Name="Tool 4">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="5" Name="Tool 5">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="6" Name="Tool 6">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="7" Name="Tool 7">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="8" Name="Tool 8">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="9" Name="Tool 9">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="10" Name="Tool 10">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="11" Name="Tool 11">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="12" Name="Tool 12">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="13" Name="Tool 13">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="14" Name="Tool 14">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="15" Name="Tool 15">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
          <Tool Number="16" Name="Tool 16">
            <ToolEnabled>0</ToolEnabled>
            <TCPVector_X>0</TCPVector_X>
            <TCPVector_Y>0</TCPVector_Y>
            <TCPVector_Z>0</TCPVector_Z>
            <Sphere Number="1">
              <SphereEnabled>1</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="2">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="3">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="4">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="5">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
            <Sphere Number="6">
              <SphereEnabled>0</SphereEnabled>
              <X>0</X>
              <Y>0</Y>
              <Z>0</Z>
              <Radius>250</Radius>
            </Sphere>
          </Tool>
        </Tools>
        <GlobalParameters>
          <MasteringTestInput>0</MasteringTestInput>
          <GlobalCartVel>10000</GlobalCartVel>
          <InpRedVelCartVel>30000</InpRedVelCartVel>
          <T1CartVel>250</T1CartVel>
          <GlobalAxisVel_rot>1000</GlobalAxisVel_rot>
          <GlobalAxisVel_lin>5000</GlobalAxisVel_lin>
        </GlobalParameters>
      </SafetyParameters>
    </encryptedData>
  </KUKARoboter.SafeRobot.Parameters>
</configuration>
};

say $OUTFILE $xml;
close $OUTFILE or die "can't close file: $!";

print "\nProcessing Completed. \n\n";
