using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_Parametros_Info
    {
        public int IdEmpresa { get; set; }
        public Nullable<int> IdTipoCbte_AsientoSueldoXPagar { get; set; }
        public Nullable<int> IdTipoCbte_AsientoProvision { get; set; }
        public Nullable<int> IdTipo_mov_Ingreso { get; set; }
        public Nullable<int> IdTipo_mov_Egreso { get; set; }
        public Nullable<int> Dias_considerado_ultimo_pago_quincela_Liq { get; set; }
        public Nullable<int> IdNomina_Tipo_Para_Desc_Automat { get; set; }
        public Nullable<int> IdNominatipoLiq_Para_Desc_Automat { get; set; }
        public Nullable<bool> GeneraraOP_PagoTerceros { get; set; }
        public string IdTipoOP_PagoTerceros { get; set; }
        public Nullable<int> IdTipoFlujoOP_PagoTerceros { get; set; }
        public string IdFormaOP_PagoTerceros { get; set; }
        public Nullable<int> IdBancoOP_PagoTerceros { get; set; }
        public Nullable<bool> GeneraOP_PagoPrestamos { get; set; }
        public string IdTipoOP_PagoPrestamos { get; set; }
        public Nullable<int> IdTipoFlujoOP_PagoPrestamos { get; set; }
        public string IdFormaOP_PagoPrestamos { get; set; }
        public Nullable<int> IdBancoOP_PagoPrestamos { get; set; }
        public Nullable<bool> GeneraOP_LiquidacionVacaciones { get; set; }
        public string IdTipoOP_LiquidacionVacaciones { get; set; }
        public Nullable<int> IdTipoFlujoOP_LiquidacionVacaciones { get; set; }
        public string IdFormaOP_LiquidacionVacaciones { get; set; }
        public Nullable<int> IdBancoOP_LiquidacionVacaciones { get; set; }
        public Nullable<bool> DescuentaIESS_LiquidacionVacaciones { get; set; }
        public string cta_contable_IESS_Vacaciones { get; set; }
        public Nullable<bool> GeneraOP_ActaFiniquito { get; set; }
        public string IdTipoOP_ActaFiniquito { get; set; }
        public Nullable<int> IdTipoFlujoOP_ActaFiniquito { get; set; }
        public string IdFormaPagoOP_ActaFiniquito { get; set; }
        public Nullable<int> IdBancoOP_ActaFiniquito { get; set; }
        public string Descripcion { get; set; }

        public List<ro_Config_Param_contable_Info> lst_cta_x_rubros { get; set; }
        public List<ro_Config_Param_contable_Info> lst_cta_x_provisiones { get; set; }

        public List<ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Info> lst_cta_x_sueldo_pagar { get; set; }

        public ro_Parametros_Info()
        {
            lst_cta_x_rubros = new List<ro_Config_Param_contable_Info>();
            lst_cta_x_sueldo_pagar = new List<ro_parametro_contable_x_Nomina_Tipoliqui_Sueldo_x_Pagar_Info>();
            lst_cta_x_provisiones = new List<ro_Config_Param_contable_Info>();
        }
    }

   
}
