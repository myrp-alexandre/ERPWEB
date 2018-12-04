using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Presupuesto
{
    public class pre_Grupo_x_seg_usuario_Info
    {
        public int IdEmpresa { get; set; }
        public int IdGrupo { get; set; }
        public int Secuencia { get; set; }
        [Required(ErrorMessage = ("El campo descripción es obligatorio"))]
        public string IdUsuario { get; set; }
        public bool AsignaCuentas { get; set; }

        public string Nombre { get; set; }
    }
}
