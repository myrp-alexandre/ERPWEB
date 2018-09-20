using Core.Erp.Data.Inventario;
using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Bus.Inventario
{
    public class in_Ing_Egr_Inven_distribucion_Bus
    {
        #region variables
        in_Ing_Egr_Inven_distribucion_Data oData = new in_Ing_Egr_Inven_distribucion_Data();
        List<in_Ing_Egr_Inven_distribucion_Info> list_distribuir = new List<in_Ing_Egr_Inven_distribucion_Info>();
        List<in_Ing_Egr_Inven_distribucion_Info> lst_distribuidos = new List<in_Ing_Egr_Inven_distribucion_Info>();
        in_Ing_Egr_Inven_distribucion_Info info_info_distribucion_in = new in_Ing_Egr_Inven_distribucion_Info();
        in_Ing_Egr_Inven_distribucion_Data bus_info_distribucion_in = new in_Ing_Egr_Inven_distribucion_Data();
        List<in_Motivo_Inven_Info> lst_motivo_inve = new List<in_Motivo_Inven_Info>();
        in_Motivo_Inven_Data data_motivo = new in_Motivo_Inven_Data();
        in_Motivo_Inven_Info info_motivo = new in_Motivo_Inven_Info();
        in_Ing_Egr_Inven_Bus bus_ing_egr = new in_Ing_Egr_Inven_Bus();
        in_Ing_Egr_Inven_Info mov_sin_lote = new in_Ing_Egr_Inven_Info();
        in_Ing_Egr_Inven_distribucion_Info distribucion_sin_lote = new in_Ing_Egr_Inven_distribucion_Info();
        in_Ing_Egr_Inven_distribucion_Info distribucion_con_lote = new in_Ing_Egr_Inven_distribucion_Info();
        #endregion


        public List<in_Ing_Egr_Inven_distribucion_Info> get_list(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                return oData.get_list(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception )
            {
                throw;
            }
        }
        public List<in_Ing_Egr_Inven_distribucion_Info> get_list(int IdEmpresa, DateTime FechaInicio, DateTime FechaFin)
        {
            try
            {
                return oData.get_list(IdEmpresa, FechaInicio,FechaFin);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public in_Ing_Egr_Inven_distribucion_Info get_info(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi, string signo)
        {
            try
            {
                return oData.get_info(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi, signo);
            }
            catch (Exception )
            {
                throw;
            }

        }

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo)
        {
            try
            {
                return oData.get_list(IdEmpresa, IdSucursal, IdMovi_inven_tipo);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list_x_distribuir(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                return oData.get_list_x_distribuir(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list_distribuido(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                return oData.get_list_distribuido(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public bool guardarDB(List<in_Ing_Egr_Inven_distribucion_Info> lista)
        {
            try
            {
                return oData.guardarDB(lista);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public bool guardarDB(in_Ing_Egr_Inven_distribucion_Info info)
        {
            try
            {
                return grabar_movimientos_x_distribucion(info);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public bool eliminarDB(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, int IdNumMovi)
        {
            try
            {
                return oData.eliminarDB(IdEmpresa, IdSucursal, IdMovi_inven_tipo, IdNumMovi);
            }
            catch (Exception )
            {
                throw;
            }
        }



        private bool grabar_movimientos_x_distribucion( in_Ing_Egr_Inven_distribucion_Info info_distribucion)
        {
            try
            {
               
                info_info_distribucion_in = bus_info_distribucion_in.get_info(info_distribucion.IdEmpresa, info_distribucion.IdSucursal,info_distribucion.IdMovi_inven_tipo, info_distribucion.IdNumMovi, (info_distribucion.signo == "+" ? "-" : "+"));
                lst_motivo_inve = data_motivo.get_list(info_distribucion.IdEmpresa,false);
                distribucion_sin_lote = oData.get_info(info_distribucion.IdEmpresa, info_distribucion.IdSucursal, info_distribucion.IdMovi_inven_tipo, info_distribucion.IdNumMovi, (info_distribucion.signo == "+" ? "-" : "+"));
                distribucion_con_lote = oData.get_info(info_distribucion.IdEmpresa, info_distribucion.IdSucursal, info_distribucion.IdMovi_inven_tipo, info_distribucion.IdNumMovi, info_distribucion.signo);
               
                #region Crear movimiento sin lote
                if (info_info_distribucion_in == null)
                    info_info_distribucion_in = info_distribucion;
                #region Cabecera
                if (distribucion_sin_lote != null)
                    mov_sin_lote = bus_ing_egr.get_info(distribucion_sin_lote.IdEmpresa_dis, distribucion_sin_lote.IdSucursal_dis, distribucion_sin_lote.IdMovi_inven_tipo_dis, distribucion_sin_lote.IdNumMovi_dis);
                else
                {
                    info_motivo = lst_motivo_inve.FirstOrDefault(q => q.Genera_Movi_Inven == "S" && q.Tipo_Ing_Egr == (info_distribucion.signo == "+" ? "EGR" : "ING"));
                    if (info_motivo == null)
                    {
                        return false;
                    }

                    mov_sin_lote = new in_Ing_Egr_Inven_Info
                    {
                        IdEmpresa = info_distribucion.IdEmpresa,
                        IdSucursal = info_distribucion.IdSucursal,
                        IdMovi_inven_tipo = info_distribucion.signo == "+" ? Convert.ToInt32(info_info_distribucion_in.IdMovi_inven_tipo) : Convert.ToInt32(info_info_distribucion_in.IdMovi_inven_tipo),
                        IdNumMovi = 0,
                        IdBodega = info_distribucion.IdBodega,
                        signo = (info_distribucion.signo == "+" ? "-" : "+"),
                        CodMoviInven = "Dis_" + info_distribucion.IdEmpresa.ToString("00") + "_" + info_distribucion.IdSucursal.ToString("00") + "_" + info_distribucion.IdMovi_inven_tipo.ToString("00") + "_" + info_distribucion.IdNumMovi.ToString("000000000"),
                        cm_observacion = "Dis. x lote ",
                        cm_fecha = DateTime.Now.Date,
                        IdUsuario = info_distribucion.IdUsuario,
                        Estado = "A",
                        Fecha_Transac = DateTime.Now,
                        IdMotivo_Inv = info_motivo.IdMotivo_Inv
                    };
                }
                #endregion

                #region Detalle
                foreach (var item in info_distribucion.lst_x_distribuir)
                {
                    if (item.can_distribuida > 0)
                    {
                        in_Ing_Egr_Inven_det_Info info_det = new in_Ing_Egr_Inven_det_Info
                        {
                            IdEmpresa = mov_sin_lote.IdEmpresa,
                            IdSucursal = mov_sin_lote.IdSucursal,
                            IdMovi_inven_tipo = mov_sin_lote.IdMovi_inven_tipo,
                            IdNumMovi = mov_sin_lote.IdNumMovi,
                            IdBodega = (int)mov_sin_lote.IdBodega,
                            IdProducto = item.IdProducto,
                            dm_observacion = "",
                            dm_cantidad = item.can_distribuida == null ? 0 : Convert.ToDouble(item.can_distribuida) * (info_distribucion.signo == "+" ? -1 : 1),
                            dm_cantidad_sinConversion = item.can_distribuida == null ? 0 : Convert.ToDouble(item.can_distribuida),
                            mv_costo = item.mv_costo,
                            mv_costo_sinConversion = item.mv_costo,
                            IdUnidadMedida = item.IdUnidadMedida,
                            IdUnidadMedida_sinConversion = item.IdUnidadMedida,
                        };
                        mov_sin_lote.lst_in_Ing_Egr_Inven_det.Add(info_det);
                    }
                }
                #endregion

                #endregion

                #region Crear movimiento con lote
                in_Ing_Egr_Inven_Info mov_con_lote = new in_Ing_Egr_Inven_Info();

                #region Cabecera
                if (distribucion_con_lote != null)
                    mov_con_lote = bus_ing_egr.get_info(distribucion_con_lote.IdEmpresa_dis, distribucion_con_lote.IdSucursal_dis, distribucion_con_lote.IdMovi_inven_tipo_dis, distribucion_con_lote.IdNumMovi_dis);
                else
                {
                    info_motivo = lst_motivo_inve.FirstOrDefault(q => q.Genera_Movi_Inven == "S" && q.Tipo_Ing_Egr == (info_distribucion.signo == "+" ? "ING" : "EGR"));
                    if (info_motivo == null)
                    {
                        return false;
                    }

                    mov_con_lote = new in_Ing_Egr_Inven_Info
                    {
                        IdEmpresa = info_distribucion.IdEmpresa,
                        IdSucursal = info_distribucion.IdSucursal,
                        IdMovi_inven_tipo = info_distribucion.signo == "+" ? Convert.ToInt32(info_info_distribucion_in.IdMovi_inven_tipo) : Convert.ToInt32(info_info_distribucion_in.IdMovi_inven_tipo),
                        IdNumMovi = 0,
                        IdBodega = info_distribucion.IdBodega,
                        signo = info_distribucion.signo,
                        CodMoviInven = "Dis_" + info_distribucion.IdEmpresa.ToString("00") + "_" + info_distribucion.IdSucursal.ToString("00") + "_" + info_distribucion.IdMovi_inven_tipo.ToString("00") + "_" + info_distribucion.IdNumMovi.ToString("000000000"),
                        cm_observacion = "Dis. x lote - Sucursal: ",
                        cm_fecha = DateTime.Now.Date,
                        IdUsuario = info_distribucion.IdUsuario,
                        Estado = "A",
                        Fecha_Transac = DateTime.Now,
                        nom_pc = "",
                        ip = "",
                        IdMotivo_Inv = info_motivo.IdMotivo_Inv
                    };
                }
                #endregion

                #region Detalle
                foreach (var item in info_distribucion.lst_distribuido)
                {
                    in_Ing_Egr_Inven_det_Info info_det = new in_Ing_Egr_Inven_det_Info
                    {
                        IdEmpresa = mov_sin_lote.IdEmpresa,
                        IdSucursal = mov_sin_lote.IdSucursal,
                        IdMovi_inven_tipo = mov_sin_lote.IdMovi_inven_tipo,
                        IdNumMovi = mov_sin_lote.IdNumMovi,
                        IdBodega =(int)info_distribucion.IdBodega,
                        IdProducto = item.IdProducto,
                        dm_observacion = "",
                        dm_cantidad = item.dm_cantidad == null ? 0 : Convert.ToDouble(item.dm_cantidad) * (info_distribucion.signo == "+" ? 1 : -1),
                        dm_cantidad_sinConversion = item.dm_cantidad == null ? 0 : Convert.ToDouble(item.dm_cantidad),
                        mv_costo = item.mv_costo,
                        mv_costo_sinConversion = item.mv_costo,
                        IdUnidadMedida = item.IdUnidadMedida,
                        IdUnidadMedida_sinConversion = item.IdUnidadMedida,
                    };
                    mov_con_lote.lst_in_Ing_Egr_Inven_det.Add(info_det);
                }
                #endregion

                #endregion

                #region guardar movimientos y distribucion
                if (distribucion_sin_lote == null)
                {
                    if (!bus_ing_egr.guardarDB(mov_sin_lote,""))
                        return false;

                    distribucion_sin_lote = new in_Ing_Egr_Inven_distribucion_Info
                    {
                        IdEmpresa = info_distribucion.IdEmpresa,
                        IdSucursal = info_distribucion.IdSucursal,
                        IdMovi_inven_tipo = info_distribucion.IdMovi_inven_tipo,
                        IdNumMovi = info_distribucion.IdNumMovi,

                        IdEmpresa_dis = mov_sin_lote.IdEmpresa,
                        IdSucursal_dis = mov_sin_lote.IdSucursal,
                        IdMovi_inven_tipo_dis = mov_sin_lote.IdMovi_inven_tipo,
                        IdNumMovi_dis = mov_sin_lote.IdNumMovi,
                        signo = mov_sin_lote.signo,
                        estado = true,
                    };

                    if (!oData.guardarDB(distribucion_sin_lote))
                        return false;
                }
                else
                {
                    if (!bus_ing_egr.Reversar_Aprobacion(distribucion_sin_lote.IdEmpresa_dis, distribucion_sin_lote.IdSucursal_dis, distribucion_sin_lote.IdMovi_inven_tipo_dis, distribucion_sin_lote.IdNumMovi_dis, "S"))
                        return false;

                    if (!bus_ing_egr.modificarDB(mov_sin_lote))
                        return false;
                }

                if (distribucion_con_lote == null)
                {
                    if (!bus_ing_egr.guardarDB(mov_con_lote, mov_con_lote.signo))
                        return false;

                    distribucion_con_lote = new in_Ing_Egr_Inven_distribucion_Info
                    {
                        IdEmpresa = info_distribucion.IdEmpresa,
                        IdSucursal = info_distribucion.IdSucursal,
                        IdMovi_inven_tipo = info_distribucion.IdMovi_inven_tipo,
                        IdNumMovi = info_distribucion.IdNumMovi,

                        IdEmpresa_dis = mov_con_lote.IdEmpresa,
                        IdSucursal_dis = mov_con_lote.IdSucursal,
                        IdMovi_inven_tipo_dis = mov_con_lote.IdMovi_inven_tipo,
                        IdNumMovi_dis = mov_con_lote.IdNumMovi,
                        signo = mov_con_lote.signo,
                        estado = true,
                    };

                    if (!oData.guardarDB(distribucion_con_lote))
                        return false;
                }
                else
                {
                    if (!bus_ing_egr.Reversar_Aprobacion(distribucion_con_lote.IdEmpresa_dis, distribucion_con_lote.IdSucursal_dis, distribucion_con_lote.IdMovi_inven_tipo_dis, distribucion_con_lote.IdNumMovi_dis, "S"))
                        return false;

                    if (!bus_ing_egr.modificarDB(mov_con_lote))
                        return false;
                }
                #endregion

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}

