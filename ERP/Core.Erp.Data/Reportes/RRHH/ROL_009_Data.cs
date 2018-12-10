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
        public List<ROL_009_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime fecha_fin, string estado_novedad, string IdRubro, decimal IdEmpleado)
        {
            try
            {
                fecha_inicio = fecha_inicio.Date;
                fecha_fin = fecha_fin.Date;
                decimal IdEmpleadoInicio = IdEmpleado;
                decimal IdEmpleadoFin = IdEmpleado == 0 ? 9999 : IdEmpleado;

                List<ROL_009_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                   
                    if(IdRubro=="")
                    Lista = (from q in Context.VWROL_009
                             where q.IdEmpresa == IdEmpresa
                             && q.FechaPago>=fecha_inicio
                             && q.FechaPago<=fecha_fin
                             && q.IdEmpleado>=IdEmpleadoInicio
                             && q.IdEmpleado<=IdEmpleadoFin
                             && estado_novedad.Contains(estado_novedad)

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
                                 && estado_novedad.Contains(estado_novedad)
                                 && q.IdRubro==IdRubro
                                 && q.IdEmpleado >= IdEmpleadoInicio
                                && q.IdEmpleado <= IdEmpleadoFin
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
