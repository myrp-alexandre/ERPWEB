using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
namespace Core.Erp.Data.RRHH
{
   public class ro_empleado_novedad_det_Data
    {
        
        public List<ro_empleado_novedad_det_Info> get_list(int IdEmpresa, decimal IdEmpleado, decimal IdNovedad)
        {
            try
            {
                List<ro_empleado_novedad_det_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.ro_empleado_novedad_det
                             where q.IdEmpresa == IdEmpresa
                                   & q.IdEmpleado==IdEmpleado
                                   && q.IdNovedad==IdNovedad
                             select new ro_empleado_novedad_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdNovedad = q.IdNovedad,
                                 IdNomina_tipo = q.IdNomina_tipo,
                                 IdNomina_Tipo_Liq = q.IdNomina_Tipo_Liq,
                                 IdEmpleado = q.IdEmpleado,
                                 FechaPago = q.FechaPago,
                                 Observacion = q.Observacion,
                                 Estado = q.Estado,
                                 Valor = q.Valor,
                                 IdRubro = q.IdRubro ,
                                 Secuencia=q.Secuencia                               
                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<ro_empleado_novedad_det_Info> get_list_nov_liq_empleado(int IdEmpresa, decimal IdEmpleado)
        {
            try
            {
                List<ro_empleado_novedad_det_Info> Lista;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    Lista = (from q in Context.ro_empleado_novedad_det
                             join p in Context.ro_rubro_tipo
                             on new { q.IdEmpresa, q.IdRubro} equals new {p.IdEmpresa, p.IdRubro}
                                 where q.IdEmpresa == IdEmpresa
                                   & q.IdEmpleado == IdEmpleado
                                   && q.Estado == "A"
                                   && q.EstadoCobro=="PEN"
                             select new ro_empleado_novedad_det_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdNovedad = q.IdNovedad,
                                 IdNomina_tipo = q.IdNomina_tipo,
                                 IdNomina_Tipo_Liq = q.IdNomina_Tipo_Liq,
                                 IdEmpleado = q.IdEmpleado,
                                 FechaPago = q.FechaPago,
                                 Observacion = q.Observacion,
                                 Estado = q.Estado,
                                 Valor = q.Valor,
                                 IdRubro = q.IdRubro,
                                 Secuencia = q.Secuencia,
                                 rub_tipo=p.ru_tipo
                             }).ToList();

                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_empleado_novedad_det_Info get_info(int IdEmpresa, decimal IdEmpleado, decimal IdNovedad, int Secuencia)
        {
            try
            {
                ro_empleado_novedad_det_Info info = new ro_empleado_novedad_det_Info();

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    ro_empleado_novedad_det Entity = Context.ro_empleado_novedad_det.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdEmpleado==IdEmpleado && q.IdNovedad == IdNovedad && q.Secuencia==Secuencia);
                    if (Entity == null) return null;

                    info = new ro_empleado_novedad_det_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdNovedad = Entity.IdNovedad,
                        IdNomina_tipo = Entity.IdNomina_tipo,
                        IdNomina_Tipo_Liq = Entity.IdNomina_Tipo_Liq,
                        IdEmpleado = Entity.IdEmpleado,
                        FechaPago = Entity.FechaPago,
                        Num_Horas = Entity.Num_Horas,
                        Estado = Entity.Estado,
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(List<ro_empleado_novedad_det_Info> info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    foreach (var item in info)
                    {
                        ro_empleado_novedad_det Entity = new ro_empleado_novedad_det
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdNovedad = item.IdNovedad ,
                            IdNomina_tipo = item.IdNomina_tipo,
                            IdNomina_Tipo_Liq = item.IdNomina_Tipo_Liq,
                            IdEmpleado = item.IdEmpleado,
                            FechaPago = item.FechaPago,
                            IdRubro=item.IdRubro,
                            Valor=item.Valor,
                            Observacion=item.Observacion,
                            EstadoCobro = item.EstadoCobro="PEN",
                            Estado = item.Estado = "A",
                    };
                        Context.ro_empleado_novedad_det.Add(Entity);
                    }
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool eliminarDB(ro_empleado_novedad_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    string sql = "delete ro_empleado_novedad_det where IdEmpresa='"+info.IdEmpresa+ "' and IdEmpleado='"+info.IdEmpleado+ "' and IdNovedad='"+info.IdNovedad+"'";
                    Context.Database.ExecuteSqlCommand(sql);
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool AnularD(ro_empleado_novedad_Info info)
        {
            try
            {
                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    string sql = "update ro_empleado_novedad_det set Estado='I' where IdEmpresa='" + info.IdEmpresa + "' and IdEmpleado='" + info.IdEmpleado + "' and IdNovedad='" + info.IdNovedad + "'";
                    Context.Database.ExecuteSqlCommand(sql);
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public decimal get_valor_acumulado_del_mes_x_rubro(int IdEmpresa, decimal IdEmpleado, string IdRubro, DateTime Fi, DateTime Ff)
        {
            try
            {
                decimal valor = 0;

                using (Entities_rrhh Context = new Entities_rrhh())
                {
                    var lst = from q in Context.ro_empleado_novedad_det
                              where q.IdEmpresa == IdEmpresa
                              && q.IdEmpleado == IdEmpleado
                              && q.IdRubro==IdRubro
                              && q.FechaPago>=Fi
                              && q.FechaPago <=Ff

                              select q;

                    if (lst.Count() > 0)
                        valor =Convert.ToDecimal( lst.Sum(q => q.Valor));
                }

                return valor;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
