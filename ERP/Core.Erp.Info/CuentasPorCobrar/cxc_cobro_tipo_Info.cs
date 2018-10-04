using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorCobrar
{
    public class cxc_cobro_tipo_Info
    {
        [Required(ErrorMessage = ("el campo código es obligatorio"))]
        [StringLength(20, MinimumLength = 1, ErrorMessage = "el campo código debe tener mínimo 1 caracter y máximo 20")]
        public string IdCobro_tipo { get; set; }
        [Required(ErrorMessage = ("el campo descripción es obligatorio"))]
        [StringLength(50, MinimumLength = 1, ErrorMessage = "el campo descripción debe tener mínimo 1 caracter y máximo 50")]
        public string tc_descripcion { get; set; }
        public string tc_EsCheque { get; set; }
        public string tc_Afecha { get; set; }
        public string tc_interno { get; set; }
        public string Estado { get; set; }
        public bool EstadoBool { get; set; }
        public string tc_generaNCAuto { get; set; }
        [Required(ErrorMessage = ("el campo abreviatura es obligatorio"))]
        [StringLength(5, MinimumLength = 1, ErrorMessage = "el campo abreviatura debe tener mínimo 1 caracter y máximo 5")]
        public string tc_abreviatura { get; set; }
        public string tc_cobroDirecto { get; set; }
        public string tc_cobroInDirecto { get; set; }
        public string tc_docXCobrar { get; set; }
        public int tc_Orden { get; set; }
        public string tc_seMuestraManCheque { get; set; }
        [Required(ErrorMessage = ("el campo registro es obligatorio"))]
        [StringLength(20, MinimumLength = 1, ErrorMessage = "el campo registro debe tener mínimo 1 caracter y máximo 20")]
        public string tc_Que_Tipo_Registro_Genera { get; set; }
        public string tc_Tomar_Cta_Cble_De { get; set; }
        public string tc_seCobra { get; set; }
        public string IdEstadoCobro_Inicial { get; set; }
        public string ESRetenIVA { get; set; }
        public string ESRetenFTE { get; set; }
        public Nullable<double> PorcentajeRet { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string nom_pc { get; set; }
        public string ip { get; set; }
        public string tc_SePuede_Depositar { get; set; }
        public string IdMotivo_tipo_cobro { get; set; }

        //campos que no existen en la tabla


        public List<cxc_cobro_tipo_Param_conta_x_sucursal_Info> Lst_tipo_param_det { get; set; }
        public int IdSucursal { get; set; }
        public bool tc_seMuestraManCheque_bool { get; set; }
        public bool tc_seCobra_bool { get; set; }
        public bool tc_SePuede_Depositar_bool { get; set; }
        public bool ESRetenIVA_bool { get; set; }
        public bool ESRetenFTE_bool { get; set; }
        public bool tc_EsCheque_bool { get; set; }
        public bool tc_Afecha_bool { get; set; }
        public bool tc_interno_bool { get; set; }
        public bool tc_generaNCAuto_bool { get; set; }
        public bool tc_cobroDirecto_bool { get; set; }
        public bool tc_cobroInDirecto_bool { get; set; }
        public bool tc_docXCobrar_bool { get; set; }
        public int IdEmpresa { get; set; }
    }
}
