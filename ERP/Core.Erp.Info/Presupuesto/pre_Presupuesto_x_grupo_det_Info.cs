using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Presupuesto
{
    public class pre_Presupuesto_x_grupo_det_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdPresupuesto { get; set; }
        public int IdGrupo { get; set; }
        public int IdRubro { get; set; }
        public int Secuencia { get; set; }
        [Required(ErrorMessage = ("El campo cantidad es obligatorio"))]
        public int Cantidad { get; set; }
        [Required(ErrorMessage = ("El campo monto es obligatorio"))]
        public double Monto { get; set; }
    }
}
