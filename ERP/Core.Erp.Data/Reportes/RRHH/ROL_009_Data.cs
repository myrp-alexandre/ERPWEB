using Core.Erp.Info.Helps;
using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
   public class ROL_009_Data
    {
        public List<ROL_009_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime fecha_fin, string estado_novedad, string IdRubro, decimal IdEmpleado, int IdArea, string TipoRubro)
        {
            try
            {
                fecha_inicio = fecha_inicio.Date;
                fecha_fin = fecha_fin.Date;
                decimal IdEmpleadoInicio = IdEmpleado;
                decimal IdEmpleadoFin = IdEmpleado == 0 ? 9999 : IdEmpleado;

                int IdAreaInicio = IdArea;
                int IdAreaFin = IdArea == 0 ? 9999 : IdArea;

                if (estado_novedad== "System.String[]" || estado_novedad=="")
                {
                    estado_novedad = "CAN,PEN";
                }
                if(TipoRubro=="")
                {
                    TipoRubro = "E";
                }
                List<ROL_009_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                   
                    if(IdRubro=="")
                    Lista = (from q in Context.VWROL_009
                             where q.IdEmpresa == IdEmpresa
                             && q.FechaPago>=fecha_inicio
                             && q.FechaPago<= fecha_fin
                             && estado_novedad.Contains(q.EstadoCobro)
                             && q.IdEmpleado>=IdEmpleadoInicio
                             && q.IdEmpleado<=IdEmpleadoFin

                             && q.IdArea >= IdAreaInicio
                             && q.IdArea <= IdAreaFin
                             && q.ru_tipo==TipoRubro
                             select new ROL_009_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 CedulaRuc = q.CedulaRuc,
                                 IdRubro = q.IdRubro,
                                 FechaPago = q.FechaPago,
                                 Valor = q.Valor,
                                 EstadoCobro = q.EstadoCobro,
                                 RubroDescripcion = q.RubroDescripcion,
                                 Division = q.Division,
                                 Departamento = q.Departamento,
                                 IdEmpleado = q.IdEmpleado,
                                 IdDepartamento = q.IdDepartamento,
                                 IdDivision = q.IdDivision,
                                 CodigoEmpleado = q.CodigoEmpleado,
                                 pe_apellido = q.pe_apellido,
                                 pe_nombre = q.pe_nombre,
                                 ca_descripcion = q.ca_descripcion, 
                                 NombreCompleto = q.NombreCompleto
                             }).ToList();
                    else
                        Lista = (from q in Context.VWROL_009
                                 where q.IdEmpresa == IdEmpresa
                                 && q.FechaPago >= fecha_inicio
                                 && q.FechaPago <= fecha_fin
                                 && estado_novedad.Contains(q.EstadoCobro)
                                 && q.IdRubro==IdRubro
                                 && q.IdEmpleado >= IdEmpleadoInicio
                                 && q.IdEmpleado <= IdEmpleadoFin

                                 && q.IdArea >= IdAreaInicio
                                         && q.IdArea <= IdAreaFin
                                         && q.ru_tipo == TipoRubro

                                 select new ROL_009_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     CedulaRuc = q.CedulaRuc,
                                     IdRubro = q.IdRubro,
                                     FechaPago = q.FechaPago,
                                     Valor = q.Valor,
                                     EstadoCobro = q.EstadoCobro,
                                     RubroDescripcion = q.RubroDescripcion,
                                     Division = q.Division,
                                     Departamento = q.Departamento,
                                     IdEmpleado = q.IdEmpleado,
                                     IdDepartamento = q.IdDepartamento,
                                     IdDivision = q.IdDivision,
                                     CodigoEmpleado = q.CodigoEmpleado,
                                     pe_apellido = q.pe_apellido,
                                     pe_nombre = q.pe_nombre,
                                     ca_descripcion = q.ca_descripcion,
                                     NombreCompleto = q.NombreCompleto
                                 }).ToList();


                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
