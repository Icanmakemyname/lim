﻿<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmQueryView
    Inherits System.Windows.Forms.Form

    'Form은 Dispose를 재정의하여 구성 요소 목록을 정리합니다.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Windows Form 디자이너에 필요합니다.
    Private components As System.ComponentModel.IContainer

    '참고: 다음 프로시저는 Windows Form 디자이너에 필요합니다.
    '수정하려면 Windows Form 디자이너를 사용하십시오.  
    '코드 편집기를 사용하여 수정하지 마십시오.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmQueryView))
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle2 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle3 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle5 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle4 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Me.spnlVariables = New System.Windows.Forms.Splitter()
        Me.TableLayoutPanel3 = New System.Windows.Forms.TableLayoutPanel()
        Me.lblSubject = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.RichTextBoxQuery1 = New eXperDB.Controls.RichTextBoxQuery()
        Me.dgvVariables = New eXperDB.BaseControls.DataGridView()
        Me.colVariable = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.colValue = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.colLine = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Splitter1 = New eXperDB.BaseControls.Splitter()
        Me.Panel1 = New eXperDB.BaseControls.Panel()
        Me.TreeGridView1 = New AdvancedDataGridView.TreeGridView()
        Me.colPlain = New AdvancedDataGridView.TreeGridColumn()
        Me.Panel2 = New eXperDB.BaseControls.Panel()
        Me.cmbUser = New eXperDB.BaseControls.ComboBox()
        Me.cmbDb = New eXperDB.BaseControls.ComboBox()
        Me.btnSearch = New eXperDB.BaseControls.Button()
        Me.txtPW = New eXperDB.BaseControls.TextBox()
        Me.lblPw = New eXperDB.BaseControls.Label()
        Me.txtID = New eXperDB.BaseControls.TextBox()
        Me.lblID = New eXperDB.BaseControls.Label()
        Me.txtDB = New eXperDB.BaseControls.TextBox()
        Me.lblDB = New eXperDB.BaseControls.Label()
        Me.DataGridViewTextBoxColumn1 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn2 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn3 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.chkVerbose = New eXperDB.BaseControls.CheckBox()
        Me.chkAnalyze = New eXperDB.BaseControls.CheckBox()
        Me.chkBuffers = New eXperDB.BaseControls.CheckBox()
        Me.TableLayoutPanel3.SuspendLayout()
        CType(Me.dgvVariables, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
        CType(Me.TreeGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel2.SuspendLayout()
        Me.SuspendLayout()
        '
        'spnlVariables
        '
        Me.spnlVariables.BackColor = System.Drawing.Color.DimGray
        Me.spnlVariables.Dock = System.Windows.Forms.DockStyle.Right
        Me.spnlVariables.Location = New System.Drawing.Point(655, 53)
        Me.spnlVariables.Name = "spnlVariables"
        Me.spnlVariables.Size = New System.Drawing.Size(7, 245)
        Me.spnlVariables.TabIndex = 14
        Me.spnlVariables.TabStop = False
        '
        'TableLayoutPanel3
        '
        Me.TableLayoutPanel3.BackColor = System.Drawing.Color.FromArgb(CType(CType(56, Byte), Integer), CType(CType(56, Byte), Integer), CType(CType(64, Byte), Integer))
        Me.TableLayoutPanel3.ColumnCount = 2
        Me.TableLayoutPanel3.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 30.0!))
        Me.TableLayoutPanel3.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle())
        Me.TableLayoutPanel3.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel3.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel3.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel3.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel3.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel3.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel3.Controls.Add(Me.lblSubject, 1, 0)
        Me.TableLayoutPanel3.Controls.Add(Me.Label3, 0, 0)
        Me.TableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Top
        Me.TableLayoutPanel3.Location = New System.Drawing.Point(3, 3)
        Me.TableLayoutPanel3.Name = "TableLayoutPanel3"
        Me.TableLayoutPanel3.RowCount = 1
        Me.TableLayoutPanel3.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel3.Size = New System.Drawing.Size(894, 50)
        Me.TableLayoutPanel3.TabIndex = 20
        '
        'lblSubject
        '
        Me.lblSubject.AutoSize = True
        Me.lblSubject.BackColor = System.Drawing.Color.Transparent
        Me.lblSubject.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lblSubject.ForeColor = System.Drawing.Color.White
        Me.lblSubject.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.lblSubject.Location = New System.Drawing.Point(33, 0)
        Me.lblSubject.Name = "lblSubject"
        Me.lblSubject.Size = New System.Drawing.Size(858, 50)
        Me.lblSubject.TabIndex = 0
        Me.lblSubject.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.Label3.Dock = System.Windows.Forms.DockStyle.Fill
        Me.Label3.Image = CType(resources.GetObject("Label3.Image"), System.Drawing.Image)
        Me.Label3.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.Label3.Location = New System.Drawing.Point(3, 0)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(24, 50)
        Me.Label3.TabIndex = 1
        Me.Label3.Text = "      "
        '
        'RichTextBoxQuery1
        '
        Me.RichTextBoxQuery1.AutoWordSelection = True
        Me.RichTextBoxQuery1.BackColor = System.Drawing.Color.Black
        Me.RichTextBoxQuery1.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.RichTextBoxQuery1.Comments = System.Drawing.Color.Green
        Me.RichTextBoxQuery1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.RichTextBoxQuery1.ForeColor = System.Drawing.Color.FromArgb(CType(CType(180, Byte), Integer), CType(CType(180, Byte), Integer), CType(CType(180, Byte), Integer))
        Me.RichTextBoxQuery1.Functions = System.Drawing.Color.Maroon
        Me.RichTextBoxQuery1.HideSelection = False
        Me.RichTextBoxQuery1.KeyWords = System.Drawing.Color.Blue
        Me.RichTextBoxQuery1.Location = New System.Drawing.Point(3, 53)
        Me.RichTextBoxQuery1.Name = "RichTextBoxQuery1"
        Me.RichTextBoxQuery1.Numbers = System.Drawing.Color.Magenta
        Me.RichTextBoxQuery1.Size = New System.Drawing.Size(652, 245)
        Me.RichTextBoxQuery1.StateMents = System.Drawing.Color.Blue
        Me.RichTextBoxQuery1.Strings = System.Drawing.Color.Red
        Me.RichTextBoxQuery1.TabIndex = 9
        Me.RichTextBoxQuery1.Text = ""
        Me.RichTextBoxQuery1.Types = System.Drawing.Color.Brown
        Me.RichTextBoxQuery1.VariableRegex = "\$[a-zA-Z_\d]*\b"
        Me.RichTextBoxQuery1.Variables = System.Drawing.Color.Maroon
        Me.RichTextBoxQuery1.WordWrap = False
        '
        'dgvVariables
        '
        Me.dgvVariables.AllowUserToAddRows = False
        Me.dgvVariables.AllowUserToDeleteRows = False
        Me.dgvVariables.AllowUserToOrderColumns = True
        Me.dgvVariables.AllowUserToResizeRows = False
        Me.dgvVariables.BackgroundColor = System.Drawing.Color.Black
        Me.dgvVariables.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.dgvVariables.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.[Single]
        DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle1.BackColor = System.Drawing.Color.Black
        DataGridViewCellStyle1.Font = New System.Drawing.Font("Batang", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(129, Byte))
        DataGridViewCellStyle1.ForeColor = System.Drawing.Color.White
        DataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(64, Byte), Integer), CType(CType(64, Byte), Integer))
        DataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.White
        DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.dgvVariables.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1
        Me.dgvVariables.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgvVariables.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.colVariable, Me.colValue, Me.colLine})
        DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(CType(CType(32, Byte), Integer), CType(CType(32, Byte), Integer), CType(CType(36, Byte), Integer))
        DataGridViewCellStyle2.Font = New System.Drawing.Font("Batang", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(129, Byte))
        DataGridViewCellStyle2.ForeColor = System.Drawing.Color.FromArgb(CType(CType(190, Byte), Integer), CType(CType(190, Byte), Integer), CType(CType(190, Byte), Integer))
        DataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(32, Byte), Integer), CType(CType(32, Byte), Integer), CType(CType(36, Byte), Integer))
        DataGridViewCellStyle2.SelectionForeColor = System.Drawing.Color.LightSteelBlue
        DataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]
        Me.dgvVariables.DefaultCellStyle = DataGridViewCellStyle2
        Me.dgvVariables.Dock = System.Windows.Forms.DockStyle.Right
        Me.dgvVariables.EnableHeadersVisualStyles = False
        Me.dgvVariables.GridColor = System.Drawing.Color.Gray
        Me.dgvVariables.Location = New System.Drawing.Point(662, 53)
        Me.dgvVariables.MultiSelect = False
        Me.dgvVariables.Name = "dgvVariables"
        Me.dgvVariables.RowHeadersVisible = False
        Me.dgvVariables.RowTemplate.Height = 23
        Me.dgvVariables.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect
        Me.dgvVariables.Size = New System.Drawing.Size(235, 245)
        Me.dgvVariables.TabIndex = 13
        Me.dgvVariables.TagValueMatchColor = System.Drawing.Color.Red
        Me.dgvVariables.UseTagValueMatchColor = False
        '
        'colVariable
        '
        Me.colVariable.HeaderText = "VARIABLE"
        Me.colVariable.Name = "colVariable"
        Me.colVariable.ReadOnly = True
        '
        'colValue
        '
        Me.colValue.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.colValue.HeaderText = "VALUES"
        Me.colValue.Name = "colValue"
        '
        'colLine
        '
        Me.colLine.HeaderText = "-"
        Me.colLine.Name = "colLine"
        Me.colLine.ReadOnly = True
        Me.colLine.Visible = False
        Me.colLine.Width = 30
        '
        'Splitter1
        '
        Me.Splitter1.BackColor = System.Drawing.Color.DimGray
        Me.Splitter1.CollapseImage = Nothing
        Me.Splitter1.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.Splitter1.ExpandImage = Nothing
        Me.Splitter1.Location = New System.Drawing.Point(3, 298)
        Me.Splitter1.Name = "Splitter1"
        Me.Splitter1.Size = New System.Drawing.Size(894, 7)
        Me.Splitter1.TabIndex = 11
        Me.Splitter1.TabStop = False
        '
        'Panel1
        '
        Me.Panel1.BackColor = System.Drawing.Color.Black
        Me.Panel1.Controls.Add(Me.TreeGridView1)
        Me.Panel1.Controls.Add(Me.Panel2)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.Panel1.GraColor = System.Drawing.Color.FromArgb(CType(CType(70, Byte), Integer), CType(CType(70, Byte), Integer), CType(CType(70, Byte), Integer))
        Me.Panel1.Location = New System.Drawing.Point(3, 305)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Radius = 10
        Me.Panel1.Size = New System.Drawing.Size(894, 292)
        Me.Panel1.TabIndex = 12
        '
        'TreeGridView1
        '
        Me.TreeGridView1.AllowUserToAddRows = False
        Me.TreeGridView1.AllowUserToDeleteRows = False
        Me.TreeGridView1.AllowUserToResizeColumns = False
        Me.TreeGridView1.AllowUserToResizeRows = False
        Me.TreeGridView1.BackgroundColor = System.Drawing.Color.Black
        Me.TreeGridView1.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.None
        Me.TreeGridView1.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None
        DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle3.BackColor = System.Drawing.Color.FromArgb(CType(CType(44, Byte), Integer), CType(CType(44, Byte), Integer), CType(CType(48, Byte), Integer))
        DataGridViewCellStyle3.Font = New System.Drawing.Font("Gulim", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(129, Byte))
        DataGridViewCellStyle3.ForeColor = System.Drawing.Color.White
        DataGridViewCellStyle3.SelectionBackColor = System.Drawing.Color.White
        DataGridViewCellStyle3.SelectionForeColor = System.Drawing.Color.DimGray
        DataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.TreeGridView1.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle3
        Me.TreeGridView1.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.colPlain})
        DataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle5.BackColor = System.Drawing.Color.Black
        DataGridViewCellStyle5.Font = New System.Drawing.Font("Gulim", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(129, Byte))
        DataGridViewCellStyle5.ForeColor = System.Drawing.Color.White
        DataGridViewCellStyle5.SelectionBackColor = System.Drawing.Color.Black
        DataGridViewCellStyle5.SelectionForeColor = System.Drawing.Color.White
        DataGridViewCellStyle5.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]
        Me.TreeGridView1.DefaultCellStyle = DataGridViewCellStyle5
        Me.TreeGridView1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TreeGridView1.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically
        Me.TreeGridView1.EnableHeadersVisualStyles = False
        Me.TreeGridView1.GridColor = System.Drawing.Color.Black
        Me.TreeGridView1.HideExpandeIcon = False
        Me.TreeGridView1.ImageList = Nothing
        Me.TreeGridView1.Location = New System.Drawing.Point(0, 58)
        Me.TreeGridView1.Name = "TreeGridView1"
        Me.TreeGridView1.RowHeadersVisible = False
        Me.TreeGridView1.Size = New System.Drawing.Size(894, 234)
        Me.TreeGridView1.TabIndex = 10
        '
        'colPlain
        '
        Me.colPlain.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        DataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.colPlain.DefaultCellStyle = DataGridViewCellStyle4
        Me.colPlain.DefaultNodeImage = Nothing
        Me.colPlain.HeaderText = "PLAN"
        Me.colPlain.Name = "colPlain"
        Me.colPlain.ReadOnly = True
        Me.colPlain.Resizable = System.Windows.Forms.DataGridViewTriState.[True]
        Me.colPlain.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable
        '
        'Panel2
        '
        Me.Panel2.BackColor = System.Drawing.Color.FromArgb(CType(CType(56, Byte), Integer), CType(CType(64, Byte), Integer), CType(CType(80, Byte), Integer))
        Me.Panel2.Controls.Add(Me.chkBuffers)
        Me.Panel2.Controls.Add(Me.chkAnalyze)
        Me.Panel2.Controls.Add(Me.chkVerbose)
        Me.Panel2.Controls.Add(Me.cmbUser)
        Me.Panel2.Controls.Add(Me.cmbDb)
        Me.Panel2.Controls.Add(Me.btnSearch)
        Me.Panel2.Controls.Add(Me.txtPW)
        Me.Panel2.Controls.Add(Me.lblPw)
        Me.Panel2.Controls.Add(Me.txtID)
        Me.Panel2.Controls.Add(Me.lblID)
        Me.Panel2.Controls.Add(Me.txtDB)
        Me.Panel2.Controls.Add(Me.lblDB)
        Me.Panel2.Dock = System.Windows.Forms.DockStyle.Top
        Me.Panel2.GraColor = System.Drawing.Color.FromArgb(CType(CType(70, Byte), Integer), CType(CType(70, Byte), Integer), CType(CType(70, Byte), Integer))
        Me.Panel2.Location = New System.Drawing.Point(0, 0)
        Me.Panel2.Name = "Panel2"
        Me.Panel2.Radius = 10
        Me.Panel2.Size = New System.Drawing.Size(894, 58)
        Me.Panel2.TabIndex = 11
        '
        'cmbUser
        '
        Me.cmbUser.BackColor = System.Drawing.SystemColors.Window
        Me.cmbUser.DisplayMember = "All"
        Me.cmbUser.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbUser.FixedWidth = False
        Me.cmbUser.Font = New System.Drawing.Font("Gulim", 9.2!)
        Me.cmbUser.FormattingEnabled = True
        Me.cmbUser.Location = New System.Drawing.Point(375, 4)
        Me.cmbUser.Margin = New System.Windows.Forms.Padding(3, 4, 3, 4)
        Me.cmbUser.Name = "cmbUser"
        Me.cmbUser.Necessary = False
        Me.cmbUser.Size = New System.Drawing.Size(150, 20)
        Me.cmbUser.StatusTip = ""
        Me.cmbUser.TabIndex = 22
        Me.cmbUser.ValueText = ""
        '
        'cmbDb
        '
        Me.cmbDb.BackColor = System.Drawing.SystemColors.Window
        Me.cmbDb.DisplayMember = "All"
        Me.cmbDb.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbDb.FixedWidth = False
        Me.cmbDb.Font = New System.Drawing.Font("Gulim", 9.2!)
        Me.cmbDb.FormattingEnabled = True
        Me.cmbDb.Location = New System.Drawing.Point(109, 4)
        Me.cmbDb.Margin = New System.Windows.Forms.Padding(3, 4, 3, 4)
        Me.cmbDb.Name = "cmbDb"
        Me.cmbDb.Necessary = False
        Me.cmbDb.Size = New System.Drawing.Size(150, 20)
        Me.cmbDb.StatusTip = ""
        Me.cmbDb.TabIndex = 21
        Me.cmbDb.ValueText = ""
        '
        'btnSearch
        '
        Me.btnSearch.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnSearch.CheckFillColor = System.Drawing.Color.FromArgb(CType(CType(168, Byte), Integer), CType(CType(168, Byte), Integer), CType(CType(176, Byte), Integer))
        Me.btnSearch.ControlLength = eXperDB.BaseControls.Button.enmLength.[Short]
        Me.btnSearch.FixedHeight = False
        Me.btnSearch.FixedWidth = False
        Me.btnSearch.Font = New System.Drawing.Font("Gulim", 9.0!)
        Me.btnSearch.ForeColor = System.Drawing.Color.White
        Me.btnSearch.GraColor = System.Drawing.Color.FromArgb(CType(CType(152, Byte), Integer), CType(CType(152, Byte), Integer), CType(CType(160, Byte), Integer))
        Me.btnSearch.LineColor = System.Drawing.Color.Transparent
        Me.btnSearch.Location = New System.Drawing.Point(793, 0)
        Me.btnSearch.Name = "btnSearch"
        Me.btnSearch.Radius = 10
        Me.btnSearch.Size = New System.Drawing.Size(100, 27)
        Me.btnSearch.TabIndex = 6
        Me.btnSearch.Text = "F151"
        Me.btnSearch.UnCheckFillColor = System.Drawing.Color.FromArgb(CType(CType(40, Byte), Integer), CType(CType(40, Byte), Integer), CType(CType(40, Byte), Integer))
        Me.btnSearch.UseRound = True
        Me.btnSearch.UseVisualStyleBackColor = True
        '
        'txtPW
        '
        Me.txtPW.BackColor = System.Drawing.SystemColors.Window
        Me.txtPW.code = False
        Me.txtPW.ImeMode = System.Windows.Forms.ImeMode.NoControl
        Me.txtPW.impossibleinput = ""
        Me.txtPW.Location = New System.Drawing.Point(641, 4)
        Me.txtPW.Name = "txtPW"
        Me.txtPW.Necessary = False
        Me.txtPW.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPW.PossibleInput = ""
        Me.txtPW.Prefix = ""
        Me.txtPW.Size = New System.Drawing.Size(150, 21)
        Me.txtPW.StatusTip = ""
        Me.txtPW.TabIndex = 5
        Me.txtPW.Value = ""
        '
        'lblPw
        '
        Me.lblPw.BackColor = System.Drawing.Color.Transparent
        Me.lblPw.Font = New System.Drawing.Font("Gulim", 9.0!)
        Me.lblPw.ForeColor = System.Drawing.Color.White
        Me.lblPw.LineSpacing = 0.0!
        Me.lblPw.Location = New System.Drawing.Point(535, 3)
        Me.lblPw.Name = "lblPw"
        Me.lblPw.Size = New System.Drawing.Size(100, 21)
        Me.lblPw.TabIndex = 4
        Me.lblPw.Text = "F009"
        Me.lblPw.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'txtID
        '
        Me.txtID.BackColor = System.Drawing.SystemColors.Window
        Me.txtID.code = False
        Me.txtID.ImeMode = System.Windows.Forms.ImeMode.NoControl
        Me.txtID.impossibleinput = ""
        Me.txtID.Location = New System.Drawing.Point(375, 4)
        Me.txtID.Name = "txtID"
        Me.txtID.Necessary = False
        Me.txtID.PossibleInput = ""
        Me.txtID.Prefix = ""
        Me.txtID.Size = New System.Drawing.Size(150, 21)
        Me.txtID.StatusTip = ""
        Me.txtID.TabIndex = 3
        Me.txtID.Value = ""
        Me.txtID.Visible = False
        '
        'lblID
        '
        Me.lblID.BackColor = System.Drawing.Color.Transparent
        Me.lblID.Font = New System.Drawing.Font("Gulim", 9.0!)
        Me.lblID.ForeColor = System.Drawing.Color.White
        Me.lblID.LineSpacing = 0.0!
        Me.lblID.Location = New System.Drawing.Point(269, 3)
        Me.lblID.Name = "lblID"
        Me.lblID.Size = New System.Drawing.Size(100, 21)
        Me.lblID.TabIndex = 2
        Me.lblID.Text = "F008"
        Me.lblID.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'txtDB
        '
        Me.txtDB.BackColor = System.Drawing.SystemColors.Window
        Me.txtDB.code = False
        Me.txtDB.ImeMode = System.Windows.Forms.ImeMode.NoControl
        Me.txtDB.impossibleinput = ""
        Me.txtDB.Location = New System.Drawing.Point(109, 4)
        Me.txtDB.Name = "txtDB"
        Me.txtDB.Necessary = False
        Me.txtDB.PossibleInput = ""
        Me.txtDB.Prefix = ""
        Me.txtDB.Size = New System.Drawing.Size(150, 21)
        Me.txtDB.StatusTip = ""
        Me.txtDB.TabIndex = 1
        Me.txtDB.Value = ""
        Me.txtDB.Visible = False
        '
        'lblDB
        '
        Me.lblDB.BackColor = System.Drawing.Color.Transparent
        Me.lblDB.Font = New System.Drawing.Font("Gulim", 9.0!)
        Me.lblDB.ForeColor = System.Drawing.Color.White
        Me.lblDB.LineSpacing = 0.0!
        Me.lblDB.Location = New System.Drawing.Point(3, 3)
        Me.lblDB.Name = "lblDB"
        Me.lblDB.Size = New System.Drawing.Size(100, 21)
        Me.lblDB.TabIndex = 0
        Me.lblDB.Text = "F010"
        Me.lblDB.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'DataGridViewTextBoxColumn1
        '
        Me.DataGridViewTextBoxColumn1.HeaderText = "VARIABLE"
        Me.DataGridViewTextBoxColumn1.Name = "DataGridViewTextBoxColumn1"
        Me.DataGridViewTextBoxColumn1.ReadOnly = True
        '
        'DataGridViewTextBoxColumn2
        '
        Me.DataGridViewTextBoxColumn2.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.DataGridViewTextBoxColumn2.HeaderText = "VALUES"
        Me.DataGridViewTextBoxColumn2.Name = "DataGridViewTextBoxColumn2"
        '
        'DataGridViewTextBoxColumn3
        '
        Me.DataGridViewTextBoxColumn3.HeaderText = "-"
        Me.DataGridViewTextBoxColumn3.Name = "DataGridViewTextBoxColumn3"
        Me.DataGridViewTextBoxColumn3.ReadOnly = True
        Me.DataGridViewTextBoxColumn3.Visible = False
        Me.DataGridViewTextBoxColumn3.Width = 30
        '
        'chkVerbose
        '
        Me.chkVerbose.CheckFillColor = System.Drawing.Color.FromArgb(CType(CType(127, Byte), Integer), CType(CType(127, Byte), Integer), CType(CType(127, Byte), Integer))
        Me.chkVerbose.ForeColor = System.Drawing.Color.White
        Me.chkVerbose.LineColor = System.Drawing.Color.Gray
        Me.chkVerbose.Location = New System.Drawing.Point(233, 33)
        Me.chkVerbose.Name = "chkVerbose"
        Me.chkVerbose.Radius = 10
        Me.chkVerbose.Size = New System.Drawing.Size(116, 23)
        Me.chkVerbose.TabIndex = 23
        Me.chkVerbose.Text = "Verbose"
        Me.chkVerbose.UnCheckFillColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(64, Byte), Integer), CType(CType(64, Byte), Integer))
        Me.chkVerbose.UseVisualStyleBackColor = True
        '
        'chkAnalyze
        '
        Me.chkAnalyze.CheckFillColor = System.Drawing.Color.FromArgb(CType(CType(127, Byte), Integer), CType(CType(127, Byte), Integer), CType(CType(127, Byte), Integer))
        Me.chkAnalyze.ForeColor = System.Drawing.Color.White
        Me.chkAnalyze.LineColor = System.Drawing.Color.Gray
        Me.chkAnalyze.Location = New System.Drawing.Point(109, 33)
        Me.chkAnalyze.Name = "chkAnalyze"
        Me.chkAnalyze.Radius = 10
        Me.chkAnalyze.Size = New System.Drawing.Size(116, 23)
        Me.chkAnalyze.TabIndex = 24
        Me.chkAnalyze.Text = "Analyze"
        Me.chkAnalyze.UnCheckFillColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(64, Byte), Integer), CType(CType(64, Byte), Integer))
        Me.chkAnalyze.UseVisualStyleBackColor = True
        '
        'chkBuffers
        '
        Me.chkBuffers.CheckFillColor = System.Drawing.Color.FromArgb(CType(CType(127, Byte), Integer), CType(CType(127, Byte), Integer), CType(CType(127, Byte), Integer))
        Me.chkBuffers.ForeColor = System.Drawing.Color.White
        Me.chkBuffers.LineColor = System.Drawing.Color.Gray
        Me.chkBuffers.Location = New System.Drawing.Point(353, 33)
        Me.chkBuffers.Name = "chkBuffers"
        Me.chkBuffers.Radius = 10
        Me.chkBuffers.Size = New System.Drawing.Size(116, 23)
        Me.chkBuffers.TabIndex = 26
        Me.chkBuffers.Text = "Buffers"
        Me.chkBuffers.UnCheckFillColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(64, Byte), Integer), CType(CType(64, Byte), Integer))
        Me.chkBuffers.UseVisualStyleBackColor = True
        '
        'frmQueryView
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.FromArgb(CType(CType(170, Byte), Integer), CType(CType(170, Byte), Integer), CType(CType(170, Byte), Integer))
        Me.ClientSize = New System.Drawing.Size(900, 600)
        Me.Controls.Add(Me.RichTextBoxQuery1)
        Me.Controls.Add(Me.spnlVariables)
        Me.Controls.Add(Me.dgvVariables)
        Me.Controls.Add(Me.Splitter1)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.TableLayoutPanel3)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "frmQueryView"
        Me.Padding = New System.Windows.Forms.Padding(3)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "frmQueryView"
        Me.TableLayoutPanel3.ResumeLayout(False)
        Me.TableLayoutPanel3.PerformLayout()
        CType(Me.dgvVariables, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        CType(Me.TreeGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel2.ResumeLayout(False)
        Me.Panel2.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents RichTextBoxQuery1 As eXperDB.Controls.RichTextBoxQuery
    Friend WithEvents TreeGridView1 As AdvancedDataGridView.TreeGridView
    Friend WithEvents Splitter1 As eXperDB.BaseControls.Splitter
    Friend WithEvents Panel1 As eXperDB.BaseControls.Panel
    Friend WithEvents Panel2 As eXperDB.BaseControls.Panel
    Friend WithEvents txtPW As eXperDB.BaseControls.TextBox
    Friend WithEvents lblPw As eXperDB.BaseControls.Label
    Friend WithEvents txtID As eXperDB.BaseControls.TextBox
    Friend WithEvents lblID As eXperDB.BaseControls.Label
    Friend WithEvents txtDB As eXperDB.BaseControls.TextBox
    Friend WithEvents lblDB As eXperDB.BaseControls.Label
    Friend WithEvents btnSearch As eXperDB.BaseControls.Button
    Friend WithEvents colPlain As AdvancedDataGridView.TreeGridColumn
    Friend WithEvents dgvVariables As eXperDB.BaseControls.DataGridView
    Friend WithEvents spnlVariables As System.Windows.Forms.Splitter
    Friend WithEvents colVariable As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents colValue As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents colLine As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents TableLayoutPanel3 As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents lblSubject As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents cmbDb As eXperDB.BaseControls.ComboBox
    Friend WithEvents cmbUser As eXperDB.BaseControls.ComboBox
    Friend WithEvents DataGridViewTextBoxColumn1 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn2 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn3 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents chkBuffers As eXperDB.BaseControls.CheckBox
    Friend WithEvents chkAnalyze As eXperDB.BaseControls.CheckBox
    Friend WithEvents chkVerbose As eXperDB.BaseControls.CheckBox
End Class
