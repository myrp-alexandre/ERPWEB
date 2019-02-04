using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using Core.Erp.Info.Reportes.Banco;
using System.Collections.Generic;
using Core.Erp.Bus.Reportes.Banco;

namespace Core.Erp.Web.Reportes.Banco
{
    public partial class BAN_009_Rpt : DevExpress.XtraReports.UI.XtraReport
    {
        public string usuario { get; set; }
        public string empresa { get; set; }
        public BAN_009_Rpt()
        {
            InitializeComponent();
        }

        private void BAN_009_Rpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            lbl_fecha.Text = DateTime.Now.ToString("d/MM/yyyy hh:mm:ss");
            lbl_usuario.Text = usuario;
            lbl_empresa.Text = empresa;

            int IdEmpresa = string.IsNullOrEmpty(p_IdEmpresa.Value.ToString()) ? 0 : Convert.ToInt32(p_IdEmpresa.Value);
            DateTime fecha_ini = string.IsNullOrEmpty(p_fecha_ini.Value.ToString()) ? DateTime.Now : Convert.ToDateTime(p_fecha_ini.Value);
            DateTime fecha_fin = string.IsNullOrEmpty(p_fecha_fin.Value.ToString()) ? DateTime.Now : Convert.ToDateTime(p_fecha_fin.Value);
            int IdBanco = string.IsNullOrEmpty(p_IdBanco.Value.ToString()) ? 0 : Convert.ToInt32(p_IdBanco.Value);

            BAN_009_Bus bus_rpt = new BAN_009_Bus();

            if (!Convert.ToBoolean(p_mostrar_agrupado.Value))
            {
                Detail.SortFields.Add(new GroupField("IdTipoFlujo", XRColumnSortOrder.None));
                Detail.SortFields.Add(new GroupField("IdBanco", XRColumnSortOrder.None));
            }
            else
            {
                Detail.SortFields.Add(new GroupField("IdTipoFlujo", XRColumnSortOrder.Ascending));
                Detail.SortFields.Add(new GroupField("IdBanco", XRColumnSortOrder.Ascending));
            }
            List<BAN_009_Info> lst_rpt = bus_rpt.GetList(IdEmpresa, IdBanco, fecha_ini, fecha_fin);
            this.DataSource = lst_rpt;

        }

        private void GroupHeader2_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            if (!Convert.ToBoolean(p_mostrar_agrupado.Value))
            {
                e.Cancel = true;
            }
        }

        private void GroupFooter2_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            if (!Convert.ToBoolean(p_mostrar_agrupado.Value))
            {
                e.Cancel = true;
            }
        }
    }
}
