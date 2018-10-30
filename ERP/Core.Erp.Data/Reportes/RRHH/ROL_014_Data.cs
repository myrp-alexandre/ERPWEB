using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.RRHH
{
    public class ROL_014_Data
    {
        public List<ROL_014_Info> get_list(int IdEmpresa, int IdTipoNomina)
        {
            try
            {
                List<ROL_014_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWROL_014
                             where q.IdEmpresa == IdEmpresa
                             && q.IdTipoNomina == IdTipoNomina
                             select new ROL_014_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdEmpleado = q.IdEmpleado,
                                 IdTipoNomina = q.IdTipoNomina,
                                 IdDepartamento = q.IdDepartamento,
                                 IdDivision = q.IdDivision,
                                 pe_apellido = q.pe_apellido,
                                 pe_cedulaRuc = q.pe_cedulaRuc,
                                 pe_nombre = q.pe_nombre,
                                 Decimo_Cuarto = q.Decimo_Cuarto,
                                 de_descripcion = q.de_descripcion,
                                 Decimo_Tercero = q.Decimo_Tercero,
                                 Fondos_Reservas = q.Fondos_Reservas
                             }).ToList();
                }
                Lista.ForEach(

                    item =>
                    {
                       item.de_descripcion= item.de_descripcion.Trim();
                        item.pe_nombre = item.pe_nombre + " " + item.pe_apellido;
                        if (item.Decimo_Cuarto == null)
                            item.Decimo_Cuarto = "No";
                        else
                            item.Decimo_Cuarto = "Si";
                        if (item.Decimo_Tercero == null)
                            item.Decimo_Tercero = "No";
                        else
                            item.Decimo_Tercero = "Si";
                        if (item.Fondos_Reservas == null)
                            item.Fondos_Reservas = "No";
                        else
                            item.Fondos_Reservas = "Si";
                    }

                    );
                   
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
