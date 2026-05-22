# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
import os
from glcl import *
import time

class Form1(Form):

    def __init__(self, owner):
        self.Label1 = Label(self)
        self.btClear = Button(self)
        self.btPandas = Button(self)
        self.bt10w = Button(self)
        self.btEasy = Button(self)
        self.DBGrid1 = DBGrid(self)
        self.DataSource1 = DataSource(self)
        self.ClientDataSet1 = ClientDataSet(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.btPandas.OnClick = self.btPandasClick
        self.btClear.OnClick = self.btClearClick
        self.bt10w.OnClick = self.bt10wClick
        self.btEasy.OnClick = self.btEasyClick
        ''' 在窗体上放置DBGrid、ClientDataSet、DataSource，并且设置DBGrid控件的
        DataSource属性为DataSource1，DataSource1的DataSet属性为ClientDataSet1
        '''

    def btEasyClick(self, Sender):
        # 加载简单数据演示
        self.ClientDataSet1.FileName = os.path.join(os.path.dirname(os.path.abspath(__file__)), "data.xml")
        self.ClientDataSet1.Active = True

    def bt10wClick(self, Sender):
        # 记录开始时间
        start_time = time.time()
        self.ClientDataSet1.FileName = os.path.join(os.path.dirname(os.path.abspath(__file__)), "holdings.xml")
        self.ClientDataSet1.Active = True
        # 记录结束时间
        end_time = time.time()
        # 计算执行时间（秒）
        execution_time = end_time - start_time
        print(f"十万条数据加载显示时间: {execution_time:.6f} 秒")

    def btClearClick(self, Sender):
        # 清空表格
        self.DBGrid1.DataSource.DataSet.Close()
        self.DBGrid1.Refresh()

    def btPandasClick(self, Sender):
        '''
        以下代码为AI生成，提示词：根据下面的XML，使用panda写一段代码去保存它：
        <?xml version="1.0" standalone="yes"?>
        <DATAPACKET Version="2.0">
        <METADATA>
            <FIELDS>
              <FIELD attrname="aaa" fieldtype="string" WIDTH="20"/>
            </FIELDS>
            <PARAMS/>
        </METADATA>
        <ROWDATA>
            <ROW RowState="4" aaa="aaa"/>
            <ROW RowState="4" aaa="bbbb"/>
            <ROW RowState="4" aaa="cccc"/>
        </ROWDATA>
        </DATAPACKET>

        ClientDataSet可以读取xml文件，并将它转换成数据集，要完成这一点，根节点的
        名称必须是DATAPACKET，并且版本为2.0。
        METADATA用于指出字段及参数，字段用FIELDS标识出。
        ROWDATA用于指出实际的数据，它必须与FIELDS中所指示的字段对应起来。
        如果有更复杂的结构，可以用AI去生成相应的代码。
        '''
        import pandas as pd
        from xml.etree.ElementTree import Element, SubElement, tostring
        from xml.dom import minidom

        # 创建数据
        df = pd.DataFrame({'aaa': ['aaa', 'bbbb', 'cccc']})

        # 创建XML结构
        root = Element('DATAPACKET', Version="2.0")

        # METADATA部分
        metadata = SubElement(root, 'METADATA')
        fields = SubElement(metadata, 'FIELDS')
        field = SubElement(fields, 'FIELD', attrname="aaa", fieldtype="string", WIDTH="20")
        SubElement(metadata, 'PARAMS')

        # ROWDATA部分
        rowdata = SubElement(root, 'ROWDATA')
        for value in df['aaa']:
            SubElement(rowdata, 'ROW', {'RowState': '4', 'aaa': value})

        # 生成XML字符串
        xml_declaration = '<?xml version="1.0" standalone="yes"?>\n'
        rough_string = tostring(root, 'utf-8')
        reparsed = minidom.parseString(rough_string)
        pretty_xml = reparsed.toprettyxml(indent="  ")
        pretty_xml = pretty_xml.replace('<?xml version="1.0" ?>', xml_declaration, 1)

        # 保存到文件
        with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "output.xml"), 'w', encoding='utf-8') as f:
            f.write(pretty_xml)

        print("XML文件已保存为 output.xml")
        print(pretty_xml)

        # 保存完以后用DBGridj加载显示
        self.ClientDataSet1.FileName = os.path.join(os.path.dirname(os.path.abspath(__file__)), "output.xml")
        self.ClientDataSet1.Active = True