namespace Core.Erp.Web.Reportes.RRHH
{
    partial class ROL_022_Rpt
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.xrTable1 = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow1 = new DevExpress.XtraReports.UI.XRTableRow();
            this.lbl_empresa = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell3 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow4 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell2 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell4 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow2 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell1 = new DevExpress.XtraReports.UI.XRTableCell();
            this.lbl_usuario = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableRow3 = new DevExpress.XtraReports.UI.XRTableRow();
            this.lbl_periodo = new DevExpress.XtraReports.UI.XRTableCell();
            this.lbl_fecha = new DevExpress.XtraReports.UI.XRTableCell();
            this.ReportFooter = new DevExpress.XtraReports.UI.ReportFooterBand();
            this.xrLine3 = new DevExpress.XtraReports.UI.XRLine();
            this.xrLine4 = new DevExpress.XtraReports.UI.XRLine();
            this.xrLine5 = new DevExpress.XtraReports.UI.XRLine();
            this.xrLabel23 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel21 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel20 = new DevExpress.XtraReports.UI.XRLabel();
            this.p_IdNomina = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdEmpresa = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdNominaTipo = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdPeriodo = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdSucursal = new DevExpress.XtraReports.Parameters.Parameter();
            this.P_IdDivision = new DevExpress.XtraReports.Parameters.Parameter();
            this.P_IdArea = new DevExpress.XtraReports.Parameters.Parameter();
            this.P_TipoRubro = new DevExpress.XtraReports.Parameters.Parameter();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.HeightF = 0F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // TopMargin
            // 
            this.TopMargin.HeightF = 38F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.HeightF = 38F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // ReportHeader
            // 
            this.ReportHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrTable1});
            this.ReportHeader.HeightF = 100F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // xrTable1
            // 
            this.xrTable1.Borders = ((DevExpress.XtraPrinting.BorderSide)(((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right)));
            this.xrTable1.BorderWidth = 2F;
            this.xrTable1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrTable1.Name = "xrTable1";
            this.xrTable1.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow1,
            this.xrTableRow4,
            this.xrTableRow2,
            this.xrTableRow3});
            this.xrTable1.SizeF = new System.Drawing.SizeF(1119F, 100F);
            this.xrTable1.StylePriority.UseBorders = false;
            this.xrTable1.StylePriority.UseBorderWidth = false;
            this.xrTable1.StylePriority.UseTextAlignment = false;
            this.xrTable1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrTableRow1
            // 
            this.xrTableRow1.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.lbl_empresa,
            this.xrTableCell3});
            this.xrTableRow1.Name = "xrTableRow1";
            this.xrTableRow1.Weight = 1D;
            // 
            // lbl_empresa
            // 
            this.lbl_empresa.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top)));
            this.lbl_empresa.BorderWidth = 2F;
            this.lbl_empresa.Font = new System.Drawing.Font("Verdana", 10F);
            this.lbl_empresa.Name = "lbl_empresa";
            this.lbl_empresa.StylePriority.UseBorders = false;
            this.lbl_empresa.StylePriority.UseBorderWidth = false;
            this.lbl_empresa.StylePriority.UseFont = false;
            this.lbl_empresa.StylePriority.UseTextAlignment = false;
            this.lbl_empresa.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.lbl_empresa.Weight = 2.57564297585542D;
            // 
            // xrTableCell3
            // 
            this.xrTableCell3.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Top | DevExpress.XtraPrinting.BorderSide.Right)));
            this.xrTableCell3.Font = new System.Drawing.Font("Verdana", 7F);
            this.xrTableCell3.Name = "xrTableCell3";
            this.xrTableCell3.StylePriority.UseBorders = false;
            this.xrTableCell3.StylePriority.UseFont = false;
            this.xrTableCell3.Text = "ROL_021";
            this.xrTableCell3.Weight = 0.424357024144577D;
            // 
            // xrTableRow4
            // 
            this.xrTableRow4.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell2,
            this.xrTableCell4});
            this.xrTableRow4.Name = "xrTableRow4";
            this.xrTableRow4.Weight = 1D;
            // 
            // xrTableCell2
            // 
            this.xrTableCell2.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top)));
            this.xrTableCell2.BorderWidth = 2F;
            this.xrTableCell2.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[em_ruc]")});
            this.xrTableCell2.Font = new System.Drawing.Font("Verdana", 10F);
            this.xrTableCell2.Name = "xrTableCell2";
            this.xrTableCell2.StylePriority.UseBorders = false;
            this.xrTableCell2.StylePriority.UseBorderWidth = false;
            this.xrTableCell2.StylePriority.UseFont = false;
            this.xrTableCell2.StylePriority.UseTextAlignment = false;
            this.xrTableCell2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell2.Weight = 2.57564297585542D;
            // 
            // xrTableCell4
            // 
            this.xrTableCell4.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Top | DevExpress.XtraPrinting.BorderSide.Right)));
            this.xrTableCell4.Font = new System.Drawing.Font("Verdana", 7F);
            this.xrTableCell4.Name = "xrTableCell4";
            this.xrTableCell4.StylePriority.UseBorders = false;
            this.xrTableCell4.StylePriority.UseFont = false;
            this.xrTableCell4.Weight = 0.424357024144577D;
            // 
            // xrTableRow2
            // 
            this.xrTableRow2.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell1,
            this.lbl_usuario});
            this.xrTableRow2.Name = "xrTableRow2";
            this.xrTableRow2.Weight = 1D;
            // 
            // xrTableCell1
            // 
            this.xrTableCell1.Borders = DevExpress.XtraPrinting.BorderSide.Left;
            this.xrTableCell1.Font = new System.Drawing.Font("Verdana", 10F, System.Drawing.FontStyle.Italic);
            this.xrTableCell1.Name = "xrTableCell1";
            this.xrTableCell1.StylePriority.UseBorders = false;
            this.xrTableCell1.StylePriority.UseFont = false;
            this.xrTableCell1.StylePriority.UseTextAlignment = false;
            this.xrTableCell1.Text = "REPORTE DE EGRESOS";
            this.xrTableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.xrTableCell1.Weight = 2.57564292169823D;
            // 
            // lbl_usuario
            // 
            this.lbl_usuario.Borders = DevExpress.XtraPrinting.BorderSide.Right;
            this.lbl_usuario.Font = new System.Drawing.Font("Verdana", 7F);
            this.lbl_usuario.Name = "lbl_usuario";
            this.lbl_usuario.StylePriority.UseBorders = false;
            this.lbl_usuario.StylePriority.UseFont = false;
            this.lbl_usuario.StylePriority.UseTextAlignment = false;
            this.lbl_usuario.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.lbl_usuario.Weight = 0.42435707830177D;
            // 
            // xrTableRow3
            // 
            this.xrTableRow3.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.lbl_periodo,
            this.lbl_fecha});
            this.xrTableRow3.Name = "xrTableRow3";
            this.xrTableRow3.Weight = 1D;
            // 
            // lbl_periodo
            // 
            this.lbl_periodo.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.lbl_periodo.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[Periodo]")});
            this.lbl_periodo.Name = "lbl_periodo";
            this.lbl_periodo.StylePriority.UseBorders = false;
            this.lbl_periodo.StylePriority.UseTextAlignment = false;
            this.lbl_periodo.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            this.lbl_periodo.Weight = 2.57564292169823D;
            // 
            // lbl_fecha
            // 
            this.lbl_fecha.Borders = ((DevExpress.XtraPrinting.BorderSide)((DevExpress.XtraPrinting.BorderSide.Right | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.lbl_fecha.Font = new System.Drawing.Font("Verdana", 7F);
            this.lbl_fecha.Name = "lbl_fecha";
            this.lbl_fecha.StylePriority.UseBorders = false;
            this.lbl_fecha.StylePriority.UseFont = false;
            this.lbl_fecha.StylePriority.UseTextAlignment = false;
            this.lbl_fecha.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            this.lbl_fecha.Weight = 0.42435707830177D;
            // 
            // ReportFooter
            // 
            this.ReportFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLine3,
            this.xrLine4,
            this.xrLine5,
            this.xrLabel23,
            this.xrLabel21,
            this.xrLabel20});
            this.ReportFooter.HeightF = 100F;
            this.ReportFooter.Name = "ReportFooter";
            // 
            // xrLine3
            // 
            this.xrLine3.LocationFloat = new DevExpress.Utils.PointFloat(178.9999F, 94.24982F);
            this.xrLine3.Name = "xrLine3";
            this.xrLine3.SizeF = new System.Drawing.SizeF(245.8333F, 2F);
            // 
            // xrLine4
            // 
            this.xrLine4.LocationFloat = new DevExpress.Utils.PointFloat(445.4171F, 94.24982F);
            this.xrLine4.Name = "xrLine4";
            this.xrLine4.SizeF = new System.Drawing.SizeF(245.8333F, 2F);
            // 
            // xrLine5
            // 
            this.xrLine5.LocationFloat = new DevExpress.Utils.PointFloat(711.4585F, 94.16652F);
            this.xrLine5.Name = "xrLine5";
            this.xrLine5.SizeF = new System.Drawing.SizeF(228.5415F, 2.083366F);
            // 
            // xrLabel23
            // 
            this.xrLabel23.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel23.LocationFloat = new DevExpress.Utils.PointFloat(711.4585F, 3.750118F);
            this.xrLabel23.Name = "xrLabel23";
            this.xrLabel23.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel23.SizeF = new System.Drawing.SizeF(206.6666F, 19.375F);
            this.xrLabel23.StylePriority.UseFont = false;
            this.xrLabel23.StylePriority.UseTextAlignment = false;
            this.xrLabel23.Text = "Aprobado por:";
            this.xrLabel23.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel21
            // 
            this.xrLabel21.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel21.LocationFloat = new DevExpress.Utils.PointFloat(455.3753F, 3.750118F);
            this.xrLabel21.Name = "xrLabel21";
            this.xrLabel21.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel21.SizeF = new System.Drawing.SizeF(206.6665F, 19.375F);
            this.xrLabel21.StylePriority.UseFont = false;
            this.xrLabel21.StylePriority.UseTextAlignment = false;
            this.xrLabel21.Text = "Revisado por:";
            this.xrLabel21.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // xrLabel20
            // 
            this.xrLabel20.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.xrLabel20.LocationFloat = new DevExpress.Utils.PointFloat(188.5419F, 3.750118F);
            this.xrLabel20.Name = "xrLabel20";
            this.xrLabel20.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel20.SizeF = new System.Drawing.SizeF(196.2498F, 19.375F);
            this.xrLabel20.StylePriority.UseFont = false;
            this.xrLabel20.StylePriority.UseTextAlignment = false;
            this.xrLabel20.Text = "Elaborado por:";
            this.xrLabel20.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // p_IdNomina
            // 
            this.p_IdNomina.Name = "p_IdNomina";
            this.p_IdNomina.Type = typeof(short);
            this.p_IdNomina.ValueInfo = "0";
            this.p_IdNomina.Visible = false;
            // 
            // p_IdEmpresa
            // 
            this.p_IdEmpresa.Name = "p_IdEmpresa";
            this.p_IdEmpresa.Type = typeof(short);
            this.p_IdEmpresa.ValueInfo = "0";
            this.p_IdEmpresa.Visible = false;
            // 
            // p_IdNominaTipo
            // 
            this.p_IdNominaTipo.Name = "p_IdNominaTipo";
            this.p_IdNominaTipo.Type = typeof(short);
            this.p_IdNominaTipo.ValueInfo = "0";
            this.p_IdNominaTipo.Visible = false;
            // 
            // p_IdPeriodo
            // 
            this.p_IdPeriodo.Name = "p_IdPeriodo";
            this.p_IdPeriodo.Type = typeof(short);
            this.p_IdPeriodo.ValueInfo = "0";
            this.p_IdPeriodo.Visible = false;
            // 
            // p_IdSucursal
            // 
            this.p_IdSucursal.Name = "p_IdSucursal";
            this.p_IdSucursal.Type = typeof(short);
            this.p_IdSucursal.ValueInfo = "0";
            this.p_IdSucursal.Visible = false;
            // 
            // P_IdDivision
            // 
            this.P_IdDivision.Name = "P_IdDivision";
            this.P_IdDivision.Type = typeof(short);
            this.P_IdDivision.ValueInfo = "0";
            this.P_IdDivision.Visible = false;
            // 
            // P_IdArea
            // 
            this.P_IdArea.Name = "P_IdArea";
            this.P_IdArea.Type = typeof(short);
            this.P_IdArea.ValueInfo = "0";
            this.P_IdArea.Visible = false;
            // 
            // P_TipoRubro
            // 
            this.P_TipoRubro.Name = "P_TipoRubro";
            this.P_TipoRubro.Type = typeof(short);
            this.P_TipoRubro.ValueInfo = "0";
            this.P_TipoRubro.Visible = false;
            // 
            // ROL_022_Rpt
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.ReportHeader,
            this.ReportFooter});
            this.Landscape = true;
            this.Margins = new System.Drawing.Printing.Margins(25, 25, 38, 38);
            this.PageHeight = 827;
            this.PageWidth = 1169;
            this.PaperKind = System.Drawing.Printing.PaperKind.A4;
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.p_IdNomina,
            this.p_IdEmpresa,
            this.p_IdNominaTipo,
            this.p_IdPeriodo,
            this.p_IdSucursal,
            this.P_IdDivision,
            this.P_IdArea,
            this.P_TipoRubro});
            this.Version = "17.2";
            this.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.ROL_022_Rpt_BeforePrint);
            ((System.ComponentModel.ISupportInitialize)(this.xrTable1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
        private DevExpress.XtraReports.UI.XRTable xrTable1;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow1;
        private DevExpress.XtraReports.UI.XRTableCell lbl_empresa;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell3;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow4;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell2;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell4;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow2;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell1;
        private DevExpress.XtraReports.UI.XRTableCell lbl_usuario;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow3;
        private DevExpress.XtraReports.UI.XRTableCell lbl_periodo;
        private DevExpress.XtraReports.UI.XRTableCell lbl_fecha;
        private DevExpress.XtraReports.UI.ReportFooterBand ReportFooter;
        private DevExpress.XtraReports.UI.XRLine xrLine3;
        private DevExpress.XtraReports.UI.XRLine xrLine4;
        private DevExpress.XtraReports.UI.XRLine xrLine5;
        private DevExpress.XtraReports.UI.XRLabel xrLabel23;
        private DevExpress.XtraReports.UI.XRLabel xrLabel21;
        private DevExpress.XtraReports.UI.XRLabel xrLabel20;
        public DevExpress.XtraReports.Parameters.Parameter p_IdNomina;
        public DevExpress.XtraReports.Parameters.Parameter p_IdEmpresa;
        public DevExpress.XtraReports.Parameters.Parameter p_IdNominaTipo;
        public DevExpress.XtraReports.Parameters.Parameter p_IdPeriodo;
        public DevExpress.XtraReports.Parameters.Parameter p_IdSucursal;
        public DevExpress.XtraReports.Parameters.Parameter P_IdDivision;
        public DevExpress.XtraReports.Parameters.Parameter P_IdArea;
        public DevExpress.XtraReports.Parameters.Parameter P_TipoRubro;
    }
}
