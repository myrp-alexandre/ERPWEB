using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Presupuesto
{
    public class pre_Presupuesto_x_grupo_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdPresupuesto { get; set; }
        public int IdGrupo { get; set; }
        [Required(ErrorMessage = ("El campo monto solicitado es obligatorio"))]
        public double MontoSolicitado { get; set; }
        public Nullable<double> MontoAprobado { get; set; }
    }
}
